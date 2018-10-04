Rails.application.routes.draw do
  root 'home#index'
  get 'index', to: 'home#index'
  get 'about', to: 'home#about'
  resources :posts, only: [:index, :show, :new, :edit, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
