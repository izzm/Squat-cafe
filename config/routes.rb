# Require all route constraints
Dir["#{::Rails.root.to_s}/lib/route_constraints/*"].each { |path| 
  require path 
}

RailsShop::Application.routes.draw do
  get "photo/index"

  ActiveAdmin.routes(self)
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :customers
  match '/customers/edit', 
    :controller =>'Devise::RegistrationsController', 
    :action => 'edit', :as => 'customer_root'
  
  scope '/wishlist', :controller => :wishlist do
    get   '', :action => :index,    :as => 'wishlist'
    post  '/add_good',              :as => 'wishlist_add_good'
    post  '/remove_good',           :as => 'wishlist_remove_good'
  end if false

  scope '/cart', :controller => :cart do 
    get   '', :action => :index,    :as => 'cart'
    get   '/history',               :as => 'cart_history'
    post  '/add_good',              :as => 'cart_add_good'
    post  '/remove_good',           :as => 'cart_remove_good'
    post  '/recalculate',           :as => 'cart_recalculate'
    post  '/purchase',              :as => 'cart_purchase'
    get   '/purchase/complete', :action => :purchase_complete,
                                    :as => 'cart_purchase_complete'
  end if false

  scope '/menu', :controller => :catalog do
    get   '', :action => :index
    #get   '/compare',                         :as => 'catalog_compare'
    #post  '/add_to_compare',                  :as => 'catalog_add_to_compare'
    #post  '/remove_from_compare',             :as => 'catalog_remove_from_compare'
    get '/search', :action => :search,         :as => 'catalog_search'
    get '/export', :action => :export
    
    # Constraint class in lib/GoodConstraint.rb
    #get '/*path/goods/:id', :action => :good, :as => 'good', :constraints => GoodConstraint
    # Constraint class in lib/CategoryConstraint.rb
    get '/*path', :action => :category,       :as => 'category', :constraints => CategoryConstraint
  end

  scope :controller => :photo do
    get '/photo', :action => :index, :as => 'photo'
    get '/photo/:id', :action => :single, :as => 'single_photo'
    get '/photo/album/:id', :action => :album, :as => 'photo_album'
  end

  scope :controller => :events do
    get '/events/bydate/:date', :action => :bydate, :as => 'events_bydate', :date => /\d{2}\.\d{2}\.\d{4}/
    get '/events/bydate/:date/:id', :action => :bydate_and_id, :as => 'events_bydate_and_id', :date => /\d{2}\.\d{2}\.\d{4}/
    
    get '/events/:year/:month', :action => :bymonth, :as => 'events_bymonth', :year => /\d{4}/, :month => /\d{1,2}/
    get '/events', :action => :index, :as => 'events'
  end

  scope :controller => :site do
    post '/feedback', :action => 'feedback', :as => 'feedback'
    
    match "/butik" => redirect("/page/butik")
    # Constraint class in lib/StaticPageConstraint.rb
    get '/page/*path', :action => :static_page, :as => 'static_page', :constraints => StaticPageConstraint
  end
  
  root :to => 'site#index'

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
  # root :to => 'shop#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
