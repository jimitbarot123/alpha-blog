Rails.application.routes.draw do
  devise_for :users, path: '',
              path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register'}
              #controllers: { registrations: 'users/registrations'}
  # devise_scope :user do
  #   get "users", to: "users/registrations#index"
  #   get "user", to: "users/registrations#show"
  # end
  root "pages#home"
  get 'about', to: "pages#about"
  resources :articles#, only: [:show,:index,:new,:create,:edit,:update]
  #get 'signup', to: 'users#new'
  resources :users, except: [:new,:create]
  resources :categories, except: [:destroy]
end
