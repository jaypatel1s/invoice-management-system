# frozen_string_literal: true

class Company
  # :nodoc:
  class BranchStocksController < BaseController
    before_action :set_branch_stock, only: %i[edit update destroy show]

    def index
      @branch_stocks = current_user.branch.branch_stocks.includes(:product)
    end

    def new
      @branch_stock = current_user.branch.branch_stocks.new
    end

    def create
      @branch_stock = current_user.branch.branch_stocks.new(branch_stock_params)
      if @branch_stock.save
        flash[:success] = 'Branch Stock was successfully created.'
        redirect_to company_branch_stocks_path
      else
        render :new
      end
    end

    def edit; end

    def update
      if @branch_stock.update(branch_stock_params)
        flash[:success] = 'Branch Stock was successfully updated.'
        redirect_to company_branch_stocks_path
      else
        render :edit
      end
    end

    def destroy
      @branch_stock.destroy

      flash[:success] = 'Branch Stock was successfully deleted.'
      redirect_to company_branch_stocks_path
    end

    def show; end

    private

    def branch_stock_params
      params.require(:branch_stock).permit(:product_id, :quantity)
    end

    def set_branch_stock
      @branch_stock = current_user.branch.branch_stocks.find(id: params[:id])
      return if @branch_stock.present?

      flash[:alert] = 'branch_stock not found.'
      redirect_to company_branch_stocks_path
    end
  end
end
