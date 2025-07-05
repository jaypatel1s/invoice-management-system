# frozen_string_literal: true

# :nodoc:
class BaseController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
end
