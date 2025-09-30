# frozen_string_literal: true

class Company
  class StocksController < BaseController
    before_action :set_stock, only: %i[edit update destroy show]

    def index
      @stocks = current_company.stocks.includes(:product)
    end

    def new
      @stock = current_company.stocks.new
    end

    def create
      @stock = current_company.stocks.new(stock_params)
      if @stock.save
        flash[:success] = 'Stock was successfully created.'
        redirect_to company_stocks_path
      else
        render :new
      end
    end

    def edit; end

    def update
      if @stock.update(stock_params)
        flash[:success] = 'Stock was successfully updated.'
        redirect_to company_stocks_path
      else
        render :edit
      end
    end

    def destroy
      @stock.destroy

      flash[:success] = 'Stock was successfully deleted.'
      redirect_to company_stocks_path
    end

    def show; end

    private

    def stock_params
      params.require(:stock).permit(:product_id, :quantity)
    end

    def set_stock
      @stock = current_company.stocks.find_by(id: params[:id])
      return if @stock.present?

      flash[:alert] = 'Stock not found.'
      redirect_to company_stocks_path
    end
  end
end
