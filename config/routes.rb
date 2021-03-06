RaxaVisualizations::Application.routes.draw do
  scope 'pharmacy' do
    resources :drugs, :as => :pharmacy_drugs do
      get 'time_graph', :on => :member
    end
  end

  scope 'registration', :as => :registration do
    constraints :full => /full/ do
      get 'registrars(/:full)' => 'registrars#index'
      get 'registrars/:id(/:full)' => 'registrars#show'
    end
    resources :registrars do
      get 'time_graph', :on => :member
    end
  end

  scope 'superuser', :as => :superuser do
    get 'timelines' => 'superuser#timelines'

    resources :departments do
      get 'departments/:id' => 'departments#show'
    end
  end

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

  match 'pharmacy' => 'pharmacy#index', :as => 'pharmacy'
  match 'superuser' => 'superuser#index', :as => 'superuser'
  match 'registration' => 'registration#index', :as => 'registration'
  match 'screener' => 'screener#index', :as => 'screener'

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'welcome#index', :as => 'root'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
