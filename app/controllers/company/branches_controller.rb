# frozen_string_literal: true

class Company
  # :nodoc:
  class BranchesController < BaseController
    before_action :set_branch, only: %i[edit update destroy show]

    def index
      @branches = current_company.branches
    end

    def new
      @branch = current_company.branches.new
    end

    def create
      @branch = current_company.branches.new(branch_params)

      if @branch.save
        flash[:success] = 'Branch was successfully created.'
        redirect_to company_branches_path
      else
        render :new
      end
    end

    def edit; end

    def update
      if @branch.update(branch_params)
        flash[:success] = 'Branch was successfully updated.'
        redirect_to company_branches_path
      else
        render :edit
      end
    end

    def destroy
      @branch.destroy

      flash[:success] = 'Branch was successfully deleted.'
      redirect_to company_branches_path
    end

    def show; end

    private

    def branch_params
      params.require(:branch).permit(:name, :code, :phone, :address, :email)
    end

    def set_branch
      @branch = current_company.branches.find_by(id: params[:id])
      return if @branch.present?

      flash[:alert] = 'branch not found.'
      redirect_to company_branches_path
    end
  end
end
