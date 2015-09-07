Rails.application.routes.draw do

  namespace :admin do
    resources :reports do
      collection do
        match 'loss_of_pays', :via => [:get, :post]
        match 'attendance', :via => [:get, :post]
      end      
    end

    resources :leaves do
    end

    resources :users do
        collection do
          match 'import', :via => [:get, :post]
          match 'export', :via => [:get, :post]
        end
      end
    
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  devise_for :users
  
  devise_scope :user do
    root to: "devise/sessions#new"
  end



  get '/users/:id', to: 'users#show', as: "users_show"
  get '/users_info/:ecode', to: 'users#info', as: "users_info"
  get '/users/:id/events', to: 'users#events', as: "users_events"
  get '/users/:id/leaves', to: 'users#leaves', as: "users_leaves"
  post '/users/:id/leaves', to: 'users#leaves', as: "users_deduct_leaves"
  post '/users/:id/request_comp_off', to: 'users#request_comp_off', as: "users_request_comp_off"
  get '/users/:id/comp_offs', to: 'users#comp_offs', as: "users_comp_offs"
  get '/users/:id/leaves/:leave_id', to: 'users#cancel_leaves_partial', as: "users_cancel_leaves_partial"
  delete '/users/:id/leaves/:leave_info_id', to: 'users#cancel_leaves', as: "users_cancel_leaves"
  get '/managers/:manager_id', to: 'managers#show', as: "managers_show"
  put '/managers/:manager_id/leave_approval/:leave_id', to: 'managers#leave_approval', as: "managers_leave_approval"
  put '/managers/:manager_id/compoff_approval/:compoff_id', to: 'managers#compoff_approval', as: "managers_compoff_approval"
  delete '/managers/:manager_id/leave_cancellation/:leave_id', to: 'managers#leave_cancellation', as: "managers_leave_cancellation"
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
