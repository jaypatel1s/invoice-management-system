# frozen_string_literal: true

# require 'sidekiq/web'

Rails.application.routes.draw do
  def draw(file)
    instance_eval(Rails.root.join("config/routes/#{file}.rb").read)
  end
  mount ActionCable.server => "/cable"

  # # mount Sidekiq::Web in your Rails app
  # Sidekiq::Web.use Rack::Auth::Basic, 'Protected Area' do |username, password|
  #   username == 'jay.gami@softices.in' && password == '123456'
  # end

  # # mount Sidekiq::Web in your Rails app
  # mount Sidekiq::Web => '/sidekiq'

  draw :common

  match '*path' => redirect { |_p, req|
    req.flash[:alert] = "Page doesn't exist"
    '/'
  }, via: :all, constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  }
end
