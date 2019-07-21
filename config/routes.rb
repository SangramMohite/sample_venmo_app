Rails.application.routes.draw do
  get 'users/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	resources :users do
		resources :accounts, only: [:index, :create, :destroy, :show]
		member do
			get 'balance', to: 'users#balance'
			post 'payment', to: 'users#payment'
			get 'feed', to: 'users#feed'
		end
	end
	resources :friendships, only: [:create, :destroy]
end
