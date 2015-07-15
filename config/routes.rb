Agenda::Application.routes.draw do

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  devise_for :user, :controllers => { :omniauth_callbacks => "user/omniauth_callbacks" }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  resources :home
  resources :dashboard

  get '/periods/all', to: 'periods#all'
  get '/periods/:period_id/subjects/:subject_id/tests/trabalho', to: 'tests#trabalho', as: 'trabalho'

  resources :periods do
    resources :subjects do
      resources :tests
      resources :projects
      resources :events
    end
  end
  # You can have the root of your site routed with "root"
  #root 'periods#index'

  devise_scope :user do
	  authenticated :user do
		  root 'periods#index', as: :root
	  end

	  unauthenticated do
		  root 'devise/sessions#new', as: :unauthenticated_root
	  end
  end
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
