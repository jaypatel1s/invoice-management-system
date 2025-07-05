# frozen_string_literal: true

module Users
  # :nodoc:
  class RegistrationsController < Devise::RegistrationsController
    layout 'authentication'

    def create
      build_resource(registration_params)
      resource.college_id = params['college_id']
      resource.role = 'student'
      if resource.email.present? && resource.save
        set_flash_message :notice, :signed_up_but_unconfirmed if is_navigational_format?
        sign_up(resource_name, resource)
        respond_with resource, location: authenticated_user_path(resource)
      else
        flash[:alert] = t(
          'devise.registrations.fill_data'
        )
        respond_with resource, location: new_user_registration_path
      end
    end

    private

    def registration_params
      params.require(:user).permit(
        :first_name, :middle_name, :last_name, :college_id, :name,
        :email, :password, :password_confirmation
      )
    end
  end
end
