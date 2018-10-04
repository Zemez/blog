Rails.application.routes.draw do
  root 'home#index'
  get 'index', to: 'home#index'
  get 'about', to: 'home#about'
  get '/test(/:test)',to: 'home#test'
  resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  get 'posts/page/(:page(.:format))', to: 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
