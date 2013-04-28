DOVES::Application.routes.draw do
  resources :posts do
	post 'list', :on => :collection
	end

  resources :multimedia

  resources :birds do 
	get 'toggle', :on => :member
end

resources :votes do
	get 'pending', :on => :collection
end

  root :to => "pages#home"
  match '/gettingstarted' => 'pages#gettingstarted'
  
  
resources :submissions , :shallow => true do
	resources :votes
	get 'pending', :on => :collection
	get 'new_submissions', :on => :collection
end

resources :users do
	post 'edit', :on => :member
	get 'logout', :on => :collection
	get 'login', :on => :collection
	post 'login_attempt', :on => :collection
end

resources :pages do
	get 'about', :on=> :collection
	get 'gettingstarted', :on=> :collection
	get 'home', :on=> :collection
	get 'sitemap', :on=> :collection
	get 'admin', :on=> :collection
end



	match '/404', :to => 'errors#not_found'
	match '/422', :to => 'errors#server_error'
	match '/500', :to => 'errors#server_error'
	#match '/403', :to => 'errors#forbidden'


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
