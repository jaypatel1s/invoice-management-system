# frozen_string_literal: true

module Users
  # :nodoc:
  class PasswordsController < Devise::PasswordsController
    layout 'authentication'

    def update
      self.resource = resource_class.reset_password_by_token(resource_params)

      if resource.errors.empty?
        set_flash_message(:notice, :updated_not_active) if is_navigational_format?
        respond_with resource, location: after_resetting_password_path_for(resource)
      else
        respond_with resource
      end
    end

    protected

    def after_resetting_password_path_for(resource)
      new_session_path(resource)
    end
  end
end
