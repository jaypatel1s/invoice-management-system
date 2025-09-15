# frozen_string_literal: true

# :nodoc:
class ApplicationController < ActionController::Base
  include ApplicationHelper

  helper_method :current_branch

  def set_current_branch
    @current_branch = current_user.branch
    return if @current_branch.present?

    flash[:alert] = 'Branch details not match with current user'
    redirect_to authenticated_user_path(current_user)
  end

  attr_reader :current_branch

  def authenticate_user!
    return if current_user.present?

    unauthenticated_response
  end

  def unauthenticated_response
    if request.format == 'text/html'
      redirect_to(authenticated_user_path, alert: 'You are not authorized to access this page.')
    else
      flash[:alert] = 'You are not authorized to access this page.'
      render js: "window.location = '/'"
    end
  end
end
