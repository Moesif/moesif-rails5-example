Rails.application.routes.draw do
  get 'welcome/index'

  resources :articles

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :albums, :artists
    resources :users, path: "users/:id/", only:[:create]
    resources :companies, path: "companies/:id/", only:[:create]
  end  
end
