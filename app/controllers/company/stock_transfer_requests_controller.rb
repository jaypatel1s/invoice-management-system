# frozen_string_literal: true

class Company
  class StockTransferRequestsController < BaseController
    before_action :set_request, only: [:show, :approve, :reject, :destroy]

    def index
      @stock_transfer_requests = StockTransferRequest.where(
        "source_branch_id = ? OR destination_branch_id = ?",
        current_user.branch_id, current_user.branch_id
      ).includes(:product, :source_branch, :destination_branch, :requested_by, :approved_by)
    end

    def new
      @stock_transfer_request = StockTransferRequest.new
    end

    def create
      @stock_transfer_request = Company::StockTransferService.create_transfer(stock_transfer_params, current_user)
      flash[:success] = "Stock transfer request created successfully."
      redirect_to company_stock_transfer_requests_path
    rescue => e
      flash[:alert] = "Failed to create transfer request: #{e.message}"
      render :new
    end

    def show; end

    def approve
      StockTransferService.approve_transfer(@stock_transfer_request, current_user)
      flash[:success] = "Transfer approved and stock updated."
      redirect_to company_stock_transfer_requests_path
    rescue => e
      flash[:alert] = "Approval failed: #{e.message}"
      redirect_to company_stock_transfer_requests_path
    end

    # POST /company/stock_transfer_requests/:id/reject
    def reject
      StockTransferService.reject_transfer(@stock_transfer_request, current_user)
      flash[:notice] = "Transfer rejected."
      redirect_to company_stock_transfer_requests_path
    rescue => e
      flash[:alert] = "Reject failed: #{e.message}"
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

      flash[:alert] = "Transfer request not found."
      redirect_to company_stock_transfer_requests_path
    end

    def stock_transfer_params
      params.require(:stock_transfer_request).permit(
        :source_branch_id, :destination_branch_id, :product_id, :quantity, :notes
      )
    end
  end
end
