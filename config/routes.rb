Resignako::Application.routes.draw do
  
  get "fb_oauth/start"

  get "fb_oauth/callback"

  #add action for admins other than the resource
  
  
  match 'admin_actions/manage_spam/:id/:task' => 'admin_actions#manage_spam', as: 'manage_spam'
  match 'admin_actions/manage_posts/:id/:task' => 'admin_actions#manage_posts', as: 'manage_posts'
  
  match 'admin_actions/edit_seed/:id' => 'admin_actions#edit_seed', as: 'edit_seed', via: [:get, :put]
  match 'admin_actions/force_push/:id' => 'admin_actions#force_push', as: 'force_push', via: [:post]
  match 'admin_actions/delete_queue/:id' => 'admin_actions#delete_queue', as: 'delete_queue', via: [:delete]
  match 'admin_actions/upload_advert/:id' => 'admin_actions#upload_advert', as: 'upload_advert', via: [:post, :get]
  match 'free/:hash' => 'posts#single', :as => :single
  
  match "admin_actions"   => 'admin_actions#index'
  
  get "admin_actions/manage_adverts"
  get "admin_actions/manage_queue"
  get "admin_actions/manage_spam"
  get "admin_actions/manage_posts"  
  get "admin_actions/add_seed"
  post "admin_actions/create_seed"
  post "admin_actions/consume_queue"
  get "admin_actions/consume_queue"
  
  get "admins/login"
  resources :admins
  
  #SESSIONS for ADMINS
  resources :admin_sessions, only: [:new, :create, :destroy]
  match '/signin', to: 'admin_sessions#new'
  match '/signout', to: 'admin_sessions#destroy', via: :delete
  
  match '/change_password', to: 'admin_sessions#change_password', via: [:get, :post]
  match '/change_pw', to: 'admin_sessions#admin_change_password', via: [:get, :put]
  
  get "contact_form/new"
  get "contact_form/create"
  get "company/about"
  get "company/contact"
  get "company/terms"

  get "users/add"
  get "users/edit"
  get "users/delete"

  get "posts/hot"
  get "posts/new"
  get "posts/submit"
#  get "posts/vote_up"
  get "posts/vote_down"
  get "posts/report"
  get "posts/single"
  post "posts/create"
  get "posts/verify"
  
  match "posts/vote_up/:id", to: 'posts#vote_up', as: 'post_vote_up'
  match "posts/vote_down/:id", to: 'posts#vote_down', as: 'post_vote_down'
  match "posts/update_vote_up/:id", to: 'posts#update_vote_up', as: 'post_update_vote_up'
  match "posts/update_vote_down/:id", to: 'posts#update_vote_down', as: 'post_update_vote_down'
  match "posts/report/:id", to: 'posts#report', as: 'post_report'
  
  match 'about' => 'company#about'
  #For Posts...
  match 'topgood' => 'posts#top_good'
  match 'topbad' => 'posts#top_bad'
  match 'new' => 'posts#new'
  match 'hot' => 'posts#hot'
  match 'submit' => 'posts#submit'
  match 'contact' => 'contact_form#new'
  
  match 'feed' => 'posts#feed'
  
  #For Users...
  match 'register' => 'users#register'
  
  get 'posts/fb_verify'
  get 'posts/callback'
  
  post "contact_form/create"
  
  # The priority is based upon order of creation  :
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
  
  root :to => 'posts#new'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
