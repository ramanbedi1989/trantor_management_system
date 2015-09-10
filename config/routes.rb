Rails.application.routes.draw do

  # Admin
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

  # Rails Admin
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

end
