Rails.application.routes.draw do
  resources :clients
  resources :hours
  resources :corporation_types
  resources :corporation_users do
    collection do 
      get :create_corporation_user
      get :delete_corporation_user 
    end
  end 
  resources :process_depts do 
    collection do
      get :create_process
      get :edit_process
      get :delete_process
      get :get_process_by_corporation
      get :get_process_by_client
    end
  end
  resources :appointments do 
    collection do
      post :create_appointment
      post :list_appointment
      post :update_appointment
      post :disable_appointment
      get :register_appointment
      get :delete_appointment
      get :get_appointment
      get :export
    end
  end
  resources :projects do 
    collection do 
      get :get_clients
      get :get_corporations
      get :get_contracts_by_client
      get :get_areas_by_corporation
      get :get_areas_by_client
    end
  end
  resources :contracts
  resources :corporations do 
    collection do 
      get :index_clients
      get :index_companies
      get :get_users_by_corporation
    end
  end
  resources :areas do
    collection do
      get :get_areas_by_corporation
      get :create_area_exist_corporation
      get :get_areas_by_client
      get :create_area
      get :edit_area
      get :delete_area
    end
  end
  # devise_for :users

  devise_for :users, :controllers => { :invitations => 'users/invitations' }

  get 'home/index'
  get 'home/index_company'
  get 'home/information'
  get 'home/not_found'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

end
