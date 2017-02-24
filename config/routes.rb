Rails.application.routes.draw do

  resources :clients, only: :index
  resources :projects do
      member do
        get :send_report
        get :pause
        get :resume
        get :complete
        get :cancel
      end
    resources :tasks do
      member do
        get :start
        get :pause
        get :resume
        get :complete
      end
    end
  end
  get 'static_pages/home'

  get 'static_pages/about'

  get 'static_pages/contact'

  devise_for :users
  authenticated :user do
    root 'projects#index', as: "authenticated_root"
  end
  root to: "static_pages#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
