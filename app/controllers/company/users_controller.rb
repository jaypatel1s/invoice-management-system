# frozen_string_literal: true

class Company
  # :nodoc:
  class UsersController < BaseController
    before_action :set_user, only: %i[show edit update destroy]

    def index
      @users = current_company.users.where.not(id: current_user.id)
    end

    def show; end

    def new
      @user = current_company.users.new
    end

    def edit; end

    def create
      @user = current_company.users.new(user_params)
      if @user.save
        flash[:success] = 'User Created Successfully'
        redirect_to company_users_path
      else
        flash[:alert] = @user.errors.full_messages
        render :new
      end
    end

    def update
      if @user.update(user_params)
        flash[:success] = 'User Updated Successfully'
        redirect_to company_users_path
      else
        flash[:alert] = @user.errors.full_messages
        render :edit
      end
    end

    def destroy
      @user.destroy
      flash[:success] = 'User Deleted Successfully'
      redirect_to company_users_path
    end

    private

    def set_user
      @user = current_company.users.find_by(id: params[:id])
      return if @user.present?

      flash[:notice] = 'User Not Found'
      redirect_to company_users_path
    end

    def user_params
      params.require(:user).permit(
        :name, :email, :role, :branch_id, :password, :password_confirmation
      )
    end
  end
end
