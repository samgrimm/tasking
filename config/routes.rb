Rails.application.routes.draw do
  resources :projects
  get 'static_pages/home'

  get 'static_pages/about'

  get 'static_pages/contact'

  devise_for :users
  root to: "static_pages#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
