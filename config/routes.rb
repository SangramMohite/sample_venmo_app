Rails.application.routes.draw do
  get 'users/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root 'application#hello'
	# get '/signup', to: 'users#new'
 #  	post '/signup', to: 'users#create'

	resources :users do
		resources :accounts, only: [:index, :create, :destroy, :show]
		get 'balance', to: 'accounts#balance'
	end
	
	# get 'users/{id}/balance', to: 'accounts#show'
end
