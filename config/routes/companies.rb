resources :companies, only: %i[index update] do
  collection do
    get :edit
  end
end