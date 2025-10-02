# frozen_string_literal: true

class Company
  # :nodoc:
  class StockTransferService
    attr_accessor :params, :user, :request, :object, :errors

    def initialize(request, **args)
      @request = request
      @user = args[:user]
      @params = args[:params]
      @object = args[:object]
      @errors = []
    end

    def call
      create_transfer_record if request == 'requesting'
      update_transfer_record if request == 'updating'
      approve_transfer_request if request == 'approving'
      reject_transfer_request if request == 'rejecting'

      return failure_response if @errors.any?

      { success: true, errors: [] }
    end

    def create_transfer_record
      source_branch = Branch.find_by(id: params[:source_branch_id])
      product = Product.find_by(id: params[:product_id])
      destination_branch = user.branch

      @errors << 'Source branch not found' if source_branch.nil?
      @errors << 'Product not found' if product.nil?
      @errors << 'Quantity must be greater than zero' if params[:quantity].to_i <= 0
      @errors << 'Cannot transfer to the same branch' if source_branch == destination_branch

      return if @errors.present?

      StockTransferRequest.create!(
        source_branch: source_branch,
        destination_branch: destination_branch,
        product: product,
        quantity: params[:quantity].to_i,
        notes: params[:notes],
        requested_by: user,
        status: :pending
      )
    end

    def update_transfer_record
      object.update(params)
    end

    def approve_transfer_request
      @errors << 'Request is not pending' unless object&.pending?
      return if @errors.present?

      branch_stock_out = BranchStock.find_by(branch: object.source_branch, product: object.product)
      if branch_stock_out.nil?
        @errors << 'Source branch has no stock record'
        return
      end

      if branch_stock_out.quantity < object.quantity
        @errors << 'Insufficient stock in source branch'
        return
      end

      branch_stock_out.update(quantity: branch_stock_out.quantity - object.quantity)
      create_movement(:transfer_out, object.quantity, object.source_branch, branch_stock_out.stock)

      branch_stock_in = BranchStock.find_by(branch: object.destination_branch, product: object.product)
      branch_stock_in.update(quantity: branch_stock_in.quantity + object.quantity)
      create_movement(:transfer_in, object.quantity, object.destination_branch, branch_stock_in.stock)

      object.update(status: :approved, approved_by: user)
    end

    def reject_transfer_request
      @errors << 'Request is not pending' unless object.pending?

      object.update!(status: :rejected, approved_by: user)
    end

    def create_movement(movement_type, quantity, branch, stock)
      StockMovement.create(branch:, stock:, product: object.product, quantity:, movement_type:, reference: object)
    end

    def failure_response
      { success: false, errors: @errors }
    end
  end
end
