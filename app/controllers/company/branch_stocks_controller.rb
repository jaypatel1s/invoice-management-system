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
      @branch_stock.stock_id = fetch_current_stock(branch_stock_params)
      response = StockMovementService.new(@branch_stock.stock, branch_stock: @branch_stock,
                                                               product: @branch_stock.product, quantity: @branch_stock.quantity,
                                                               reference: @branch_stock, branch: @branch_stock.branch).call
      if response[:success]
        @branch_stock.save
        flash[:success] = 'Branch Stock was successfully created.'
        redirect_to company_branch_stocks_path
      else
        flash[:alert] = response[:errors].join(', ')
        render :new
      end
    end

    def edit; end

    def update
      @branch_stock.attributes = branch_stock_params
      return unless @branch_stock.valid?

      response = StockMovementService.new(@branch_stock.stock, branch_stock: @branch_stock,
                                                               product: @branch_stock.product, quantity: @branch_stock.quantity,
                                                               reference: @branch_stock, branch: @branch_stock.branch).call
      if response[:success]
        @branch_stock.update(branch_stock_params)
        flash[:success] = 'Branch Stock was successfully updated.'
        redirect_to company_branch_stocks_path
      else
        flash[:alert] = response[:errors].join(', ')
        render :edit
      end
    end

    def destroy
      @branch_stock.stock.update(quantity: @branch_stock.stock.quantity + @branch_stock.quantity)
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
      @branch_stock = current_user.branch.branch_stocks.find_by(id: params[:id])
      return if @branch_stock.present?

      flash[:alert] = 'Branch Stock not found.'
      redirect_to company_branch_stocks_path
    end

    def fetch_current_stock(params)
      current_company.stocks.find_by(product_id: params[:product_id])&.id
    end
  end
end
