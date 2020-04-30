Rails.application.routes.draw do
  devise_for :users, path: '',
              path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register'},
              controllers: { registrations: 'users/registrations'}
  devise_scope :user do
  #  get "users", to: "users/registrations#index"
  #  get "user", to: "users/registrations#show"
  end
  root "pages#home"
  get 'about', to: "pages#about"
  get 'users', to: 'home#index'
  get 'user', to: 'home#show'
  delete 'user', to: 'home#destroy'
  resources :articles#, only: [:show,:index,:new,:create,:edit,:update]
  #get 'signup', to: 'users#new'
  #resources :registrations, except: [:new]
  # get 'login', to: 'sessions#new'
  # post 'login', to: 'sessions#create'
  # delete 'logout', to: 'sessions#destroy'
  resources :categories, except: [:destroy]
end
