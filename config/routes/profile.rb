# frozen_string_literal: true

# :nodoc:
resources :profile, only: %i[index update change_password update_password] do
  collection do
    get :edit
  end
  member do
    get :change_password
    patch :update_password
  end
end
