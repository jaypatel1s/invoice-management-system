# frozen_string_literal: true

class Company
  # :nodoc:
  class StockTransferRequestsController < BaseController
    before_action :set_request, only: %i[show edit update approve reject destroy]

    def index
      @stock_transfer_requests = StockTransferRequest.where(
        'source_branch_id = ? OR destination_branch_id = ?',
        current_user.branch_id, current_user.branch_id
      ).includes(:product, :source_branch, :destination_branch, :requested_by, :approved_by)
    end

    def new
      @stock_transfer_request = StockTransferRequest.new
    end

    def create
      response = StockTransferService.new('requesting', params: stock_transfer_params, user: current_user,
                                                        object: @stock_transfer_request).call

      if response[:success]
        flash[:success] = 'Stock transfer request created successfully.'
        redirect_to company_stock_transfer_requests_path
      else
        flash[:alert] = response[:errors].join(', ')
        render :new
      end
    end

    def show; end

    def edit; end

    def update
      response = StockTransferService.new('updating', params: stock_transfer_params, user: current_user,
                                                      object: @stock_transfer_request).call

      if response[:success]
        flash[:success] = 'Stock transfer request updated successfully.'
        redirect_to company_stock_transfer_requests_path
      else
        flash[:alert] = response[:errors].join(', ')
        render :new
      end
    end

    def approve
      response = StockTransferService.new('approving', user: current_user,
                                                       object: @stock_transfer_request).call

      if response[:success]
        flash[:success] = 'Transfer approved and stock updated.'
      else
        flash[:alert] = "Approval failed: #{response[:errors].join(', ')}"
      end
      redirect_to company_stock_transfer_requests_path
    end

    def reject
      response = StockTransferService.new('rejecting', user: current_user,
                                                       object: @stock_transfer_request).call
      if response[:success]
        flash[:notice] = 'Transfer rejected.'
      else
        flash[:alert] = "Reject failed: #{e.message}"
      end
      redirect_to company_stock_transfer_requests_path
    end

    def destroy
      @stock_transfer_request.destroy
      flash[:success] = 'Stock transfer request was successfully deleted.'
      redirect_to company_stock_transfer_requests_path
    end

    private

    def set_request
      @stock_transfer_request = StockTransferRequest.find_by(id: params[:id])
      return if @stock_transfer_request.present?

      flash[:alert] = 'Transfer request not found.'
      redirect_to company_stock_transfer_requests_path
    end

    def stock_transfer_params
      params.require(:stock_transfer_request).permit(
        :source_branch_id, :destination_branch_id, :product_id, :quantity, :notes
      )
    end
  end
end
