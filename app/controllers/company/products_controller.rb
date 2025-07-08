# frozen_string_literal: true

class Company
  # :nodoc:
  class ProductsController < BaseController
    before_action :set_product, only: %i[edit update destroy show]

    def index
      @products = current_user.company.products
    end

    def new
      @product = current_user.company.products.new
    end

    def create
      @product = current_user.company.products.new(product_params)
      @product.company_id = current_user.company_id

      if @product.save
        flash[:success] = 'Product was successfully created.'
        redirect_to company_products_path
      else
        render :new
      end
    end

    def edit; end

    def update
      if @product.update(product_params)
        flash[:success] = 'Product was successfully updated.'
        redirect_to company_products_path
      else
        render :edit
      end
    end

    def destroy
      @product.destroy

      flash[:success] = 'Product was successfully deleted.'
      redirect_to company_products_path
    end

    def show; end

    private

    def product_params
      params.require(:product).permit(:name, :description, :price)
    end

    def set_product
      @product = current_user.company.products.find(params[:id])
      return if @product.present?

      flash[:alert] = 'Product not found.'
      redirect_to company_products_path
    end
  end
end
