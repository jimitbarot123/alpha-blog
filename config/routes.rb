Rails.application.routes.draw do
  devise_for :members, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register'}
  root "pages#home"
  get 'about', to: "pages#about"
  resources :articles#, only: [:show,:index,:new,:create,:edit,:update]
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :categories, except: [:destroy]
end
