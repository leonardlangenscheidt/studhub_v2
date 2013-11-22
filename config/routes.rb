Studhub::Application.routes.draw do

	#static routes
	root :to => 'pages#home'
	get 'about' => 'pages#about'
	get 'terms' => 'pages#terms'

	resources :addresses

	#profile and orders
	resource :user
	# resource :user do
	# 	resources :orders
	# end
	# resources :orders

	#inventory system
	get 'inv' => 'pages#dashboard'
	get 'inv/deliverables' => 'orders#deliverables'
	get 'inv/receivables' => 'orders#receivables'
	get 'inv/inventory' => 'earrings#inventory'
	get 'earrings/:id/pastorders' => 'earrings#pastorders'

	#ordercreation
	get 'orders/:id/arrival' => 'orders#arrival'
	match 'orders/:id/update' => 'orders#update', :via => [:patch]
	get 'remotecreate' => 'orders#remotecreate', :via => [:post]
	get 'user/orders/:id' => 'orders#show'
	get 'earrings/:earring_id/orders/new' => 'orders#new'
	match 'earrings/:earring_id/orders' => 'orders#create', :via => [:post]

	#earring routes
	resources :earrings do
		resource :charges
	end
	get 'earrings/:id/confirm' => 'earrings#confirm'

	#facebook routes
	match 'auth/:provider/callback', to: 'sessions#create', :via => [:get, :post]
	get 'auth/failure' => redirect('/')
	match 'signout', to: 'sessions#destroy', as: 'signout', :via => [:get, :post]

	# The priority is based upon order of creation: first created -> highest priority.
	# See how all your routes lay out with "rake routes".

	# You can have the root of your site routed with "root"
	# root 'welcome#index'

	# Example of regular route:
	#   get 'products/:id' => 'catalog#view'

	# Example of named route that can be invoked with purchase_url(id: product.id)
	#   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

	# Example resource route (maps HTTP verbs to controller actions automatically):
	#   resources :products

	# Example resource route with options:
	#   resources :products do
	#     member do
	#       get 'short'
	#       post 'toggle'
	#     end
	#
	#     collection do
	#       get 'sold'
	#     end
	#   end

	# Example resource route with sub-resources:
	#   resources :products do
	#     resources :comments, :sales
	#     resource :seller
	#   end

	# Example resource route with more complex sub-resources:
	#   resources :products do
	#     resources :comments
	#     resources :sales do
	#       get 'recent', on: :collection
	#     end
	#   end

	# Example resource route with concerns:
	#   concern :toggleable do
	#     post 'toggle'
	#   end
	#   resources :posts, concerns: :toggleable
	#   resources :photos, concerns: :toggleable

	# Example resource route within a namespace:
	#   namespace :admin do
	#     # Directs /admin/products/* to Admin::ProductsController
	#     # (app/controllers/admin/products_controller.rb)
	#     resources :products
	#   end
end
