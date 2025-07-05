# frozen_string_literal: true

module Users
  # :nodoc:
  class SessionsController < Devise::SessionsController
    layout 'authentication'
    before_action :destroy_site_session, only: :destroy

    def create
      resource = User.find_for_database_authentication(
        email: user_params[:email]
      )
      if resource&.valid_password?(user_params[:password])
        sign_in :user, resource
        flash[:success] = 'Login successfully.'
        redirect_to authenticated_user_path
      else
        flash[:alert] = 'Invalid Credentials.'
        redirect_to new_user_session_path
      end
    end

    def destroy_site_session
      session[:site_slug] = nil
    end

    def after_sign_out_path_for(resource_or_scope)
      root_url(subdomain: false)
    end


    protected

    def user_params
      params.require(:user).permit(:email, :password)
    end

    private

    def respond_to_on_destroy
      respond_to do |format|
        format.all { head :no_content }
        format.any(*navigational_formats) { redirect_to after_sign_out_path_for(resource_name), status: Devise.responder.redirect_status, allow_other_host: true}
      end
    end

    def require_no_authentication
      assert_is_devise_resource!
      return unless is_navigational_format?
      no_input = devise_mapping.no_input_strategies

      authenticated = if no_input.present?
        args = no_input.dup.push scope: resource_name
        warden.authenticate?(*args)
      else
        warden.authenticated?(resource_name)
      end

      if authenticated && resource = warden.user(resource_name)
        set_flash_message(:alert, 'already_authenticated', scope: 'devise.failure')
        redirect_to authenticated_user_path(resource)
      end
    end
  end
end
