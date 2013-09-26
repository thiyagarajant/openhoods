Openhoods::Application.routes.draw do



  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
              controllers: {omniauth_callbacks: "authentications",  registrations: "users/registrations" }

  devise_scope :user do
    get 'sign_in', :to => 'devise/sessions#new'
    get 'sign_out', :to => 'devise/sessions#destroy'
    root to: "devise/sessions#new"
  end

  # This line mounts Forem's routes at /forums by default.
  # This means, any requests to the /forums URL of your application will go to Forem::ForumsController#index.
  # If you would like to change where this extension is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Forem relies on it being the default of "forem"
  mount Forem::Engine, :at => '/forums'


  resources :events

  resources :videos

  resources :vehicles


  get "/vehicles" => 'vehicles#index', :as => "user_root"
  get "/comment" => 'vehicles#comment', :as => 'comment'
  get '/favo' => 'vehicles#add_favorite', :as => 'favo'
  get '/remove_favo' => 'vehicles#remove_favorite', :as => 'remove_favo'

  get "/dashboards" => "dashboards#index", :as => "dashboards"
  namespace :admin do
    resources :users
  end

 # devise_scope :user do
   #root to: "devise/sessions#new"
 # end
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
