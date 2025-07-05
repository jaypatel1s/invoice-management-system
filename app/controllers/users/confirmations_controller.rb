# frozen_string_literal: true

module Users
  # :nodoc:
  class ConfirmationsController < Devise::ConfirmationsController
    layout 'authentication'
  end
end
