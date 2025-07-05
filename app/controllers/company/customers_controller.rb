# frozen_string_literal: true

class Company
  # :nodoc:
  class CustomersController < BaseController
    before_action :set_customer, only: %i[edit update destroy show]

    def index
      @customers = current_user.customers
    end

    def new
      @customer = current_user.customers.new
    end

    def create
      @customer = current_user.customers.new(customer_params)
      @customer.company_id = current_user.company_id

      if @customer.save
        flash[:success] = 'Customer was successfully created.'
        redirect_to company_customers_path
      else
        render :new
      end
    end

    def edit; end

    def update
      if @customer.update(customer_params)
        flash[:success] = 'Customer was successfully updated.'
        redirect_to company_customers_path
      else
        render :edit
      end
    end

    def destroy
      @customer.destroy

      flash[:success] = 'Customer was successfully deleted.'
      redirect_to company_customers_path
    end

    def show; end

    private

    def customer_params
      params.require(:customer).permit(:name, :email, :phone, :address)
    end

    def set_customer
      @customer = current_user.customers.find(params[:id])
      return if @customer.present?

      flash[:alert] = 'Customer not found.'
      redirect_to company_customers_path
    end
  end
end
