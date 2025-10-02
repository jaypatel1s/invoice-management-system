# frozen_string_literal: true

class Company
  # :nodoc:
  class StockMovementService
    attr_accessor :stock, :product, :quantity, :reference, :source_branch, :destination_branch, :branch_stock, :branch

    def initialize(stock, **args)
      @stock = stock
      @branch = args[:branch]
      @branch_stock = args[:branch_stock]
      @product = args[:product]
      @quantity = args[:quantity]
      @reference = args[:reference]
      @source_branch = args[:source_branch]
      @destination_branch = args[:destination_branch]
      @errors = []
    end

    def call
      if branch_stock.nil? && source_branch.nil? && destination_branch.nil?
        purchase_company_stock
      elsif branch_stock.present? && source_branch.nil? && destination_branch.nil?
        allocate_to_branch
      elsif source_branch && destination_branch
        transfer_between_branches
      end

      return failure_response if @errors.any?

      { success: true, errors: [] }
    end

    def purchase_company_stock
      create_movement(:purchase, quantity, branch)
    end

    private

    def allocate_to_branch
      if stock.quantity < quantity
        return @errors << "Not enough stock in company. Available: #{stock.quantity}, requested: #{quantity}"
      end

      stock.update(quantity: stock.quantity - quantity)
      create_movement(:transfer_out, quantity, nil)
      create_movement(:transfer_in, quantity, branch)
    end

    def transfer_between_branches
      branch_stock_out = BranchStock.find_by(branch: source_branch, stock: stock, product: product)
      branch_stock_out.update(quantity: branch_stock_out.quantity - quantity)
      create_movement(:transfer_out, quantity, source_branch)

      branch_stock_in = BranchStock.find_by(branch: destination_branch, stock: stock, product: product)
      branch_stock_in.update(quantity: branch_stock_in.quantity + quantity)
      create_movement(:transfer_in, quantity, destination_branch)
    end

    def create_movement(type, qty, branch)
      StockMovement.create(
        branch: branch,
        stock: stock,
        product: product,
        quantity: qty,
        movement_type: type,
        reference: reference
      )
    end

    def failure_response
      { success: false, errors: @errors }
    end
  end
end
