# frozen_string_literal: true

class Company
  class StockTransferService
    # Create a new transfer request
    def self.create_transfer(params, user)
      source_branch = Branch.find_by(id: params[:source_branch_id])
      destination_branch = user.branch
      product = Product.find_by(id: params[:product_id])
      quantity = params[:quantity].to_i

      raise 'Quantity must be greater than zero' if quantity <= 0

      raise 'Cannot transfer to the same branch' if source_branch == destination_branch

      StockTransferRequest.create!(
        source_branch: source_branch,
        destination_branch: destination_branch,
        product: product,
        quantity: quantity,
        notes: params[:notes],
        requested_by: user,
        status: :pending
      )
    rescue StandardError => e
      # Raise to controller for flash message
      raise e
    end

    # Approve transfer request
    def self.approve_transfer(request, approver)
      raise 'Request is not pending' unless request.pending?

      ActiveRecord::Base.transaction do
        # Deduct from source branch
        source_stock = BranchStock.find_by(branch: request.source_branch, product: request.product)
        raise 'Insufficient stock in source branch' if source_stock.nil? || source_stock.quantity < request.quantity

        source_stock.adjust!(-request.quantity, movement_type: :transfer_out, reference: request)

        # Add to destination branch
        dest_stock = BranchStock.find_or_create_by(branch: request.destination_branch, product: request.product)
        dest_stock.adjust!(request.quantity, movement_type: :transfer_in, reference: request)

        # Update request status
        request.update!(status: :approved, approved_by: approver)
      end
    rescue StandardError => e
      raise e
    end

    # Reject transfer request
    def self.reject_transfer(request, approver)
      raise 'Request is not pending' unless request.pending?

      request.update!(status: :rejected, approved_by: approver)
    rescue StandardError => e
      raise e
    end
  end
end
