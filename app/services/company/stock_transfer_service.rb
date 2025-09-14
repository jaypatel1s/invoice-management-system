# frozen_string_literal: true
class Company
  class StockTransferService
    # Create a new transfer request
    def self.create_transfer(params, user)
      source_branch =  Branch.find_by(id: params[:source_branch_id])
      destination_branch = user.branch
      product = Product.find_by(id: params[:product_id])
      quantity = params[:quantity].to_i

      if quantity <= 0
        raise "Quantity must be greater than zero"
      end

      if source_branch == destination_branch
        raise "Cannot transfer to the same branch"
      end

      StockTransferRequest.create!(
        source_branch: source_branch,
        destination_branch: destination_branch,
        product: product,
        quantity: quantity,
        notes: params[:notes],
        requested_by: user,
        status: :pending
      )
    rescue => e
      # Raise to controller for flash message
      raise e
    end

    # Approve transfer request
    def self.approve_transfer(request, approver)
      unless request.pending?
        raise "Request is not pending"
      end

      ActiveRecord::Base.transaction do
        # Deduct from source branch
        source_stock = BranchStock.find_by(branch: request.source_branch, product: request.product)
        if source_stock.nil? || source_stock.quantity < request.quantity
          raise "Insufficient stock in source branch"
        end

        source_stock.adjust!(-request.quantity, movement_type: :transfer_out, reference: request)

        # Add to destination branch
        dest_stock = BranchStock.find_or_create_by(branch: request.destination_branch, product: request.product)
        dest_stock.adjust!(request.quantity, movement_type: :transfer_in, reference: request)

        # Update request status
        request.update!(status: :approved, approved_by: approver)
      end
    rescue => e
      debugger
      raise e
    end

    # Reject transfer request
    def self.reject_transfer(request, approver)
      unless request.pending?
        raise "Request is not pending"
      end

      request.update!(status: :rejected, approved_by: approver)
    rescue => e
      raise e
    end
  end
end
