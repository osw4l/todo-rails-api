Rails.application.routes.draw do
  resources :todos do
    put 'complete', on: :member
  end
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/auth/login', to: 'authentication#login'
  delete '/auth/logout', to: 'authentication#logout'
  post '/auth/register', to: 'register#sign_up'

end
