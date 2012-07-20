Kletterfreund::Application.routes.draw do

  get "register" => "users#new", as: "register"
  post "users/create", as: "users"

  get "login" => "session#new", as: "login"
  post "sessions" => "session#create", as: "sessions"
  delete "logout" => "session#destroy", as: "logout"

  
  get "areas/new" => "areas#new", as: "areas_new"
  post "areas" => "areas#create", as: "areas"
  get "areas" => "areas#create", as: "areas_map"
  put "areas" => "areas#update", as: "areas_update"
  post "areas/search_map" => "areas#search_map", as: "search_map"
  get "areas/edit/:id" => "areas#edit", as: "areas_edit"
  get "areas/:id" => "areas#show", as: "areas_show"

  post "pictures" => "pictures#create", as: "pictures"
  

  root to: "pages#home", as: "home"

  #get "pages/home"
  #resources :areas
  #resources :routes
  #resources :users

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
