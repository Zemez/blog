Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get 'index', to: 'home#index'
  get 'about', to: 'home#about'
  get '/test(/:test)',to: 'home#test'
  resources :users #, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :posts #, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  get 'posts/page/(:page(.:format))', to: 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
