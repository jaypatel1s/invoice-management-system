# frozen_string_literal: true

class Company
  class InvoicesController < BaseController
    before_action :set_invoice, only: %i[edit update destroy show]
    before_action :set_customers, only: %i[new create edit]

    def index
      @invoices = current_user.company.invoices
    end

    def new
      @invoice = current_user.company.invoices.new
    end

    def create
      @invoice = current_user.company.invoices.new(invoice_params)
      @invoice.company_id = current_user.company_id
      @invoice.user_id = current_user.id

      debugger
      if @invoice.save
        flash[:success] = 'Invoice was successfully created.'
        redirect_to company_invoices_path
      else
        render :new
      end
    end

    def edit; end

    def update
      if @invoice.update(invoice_params)
        flash[:success] = 'Invoice was successfully updated.'
        redirect_to company_invoices_path
      else
        render :edit
      end
    end

    def destroy
      @invoice.destroy
      flash[:success] = 'Invoice was successfully deleted.'
      redirect_to company_invoices_path
    end

    def show; end

    def download_pdf
      @invoice = Invoice.find(params[:id])
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "invoice#{@invoice.id}", # filename
                 template: 'invoices/download_pdf', # view template
                 layout: 'application',                # layout for PDF
                 disposition: 'attachment'          # or 'inline'
        end
      end
    end

    private

    def invoice_params
      params.require(:invoice).permit(:customer_id, :user_id, :invoice_number, :date, :due_date, :status, :note)
    end

    def set_invoice
      @invoice = current_user.company.invoices.find(params[:id])
      return if @invoice.present?

      flash[:alert] = 'Invoice not found.'
      redirect_to company_invoices_path
    end

    def set_customers
      @customers = current_user.company.customers
    end
  end
end
