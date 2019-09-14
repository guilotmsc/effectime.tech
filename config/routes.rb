Rails.application.routes.draw do
  resources :hours
  resources :corporation_types
  resources :corporation_users
  resources :process_depts do 
    collection do
      get :create_process
      get :edit_process
      get :delete_process
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
    end
  end
  resources :contracts
  resources :corporations do 
    collection do 
      get :index_clients
      get :index_companies
    end
  end
  resources :areas do
    collection do
      get :create_area
      get :edit_area
      get :delete_area
    end
  end
  resources :revenues do
    collection do
      post :registration
      post :update_amount
    end
  end
  resources :companies do
    collection do
      get :get_amounts
      get :verify_registers
      post :registration
      post :save_and_create_company_users
    end
    member do
      get :investments
      get :financings
      get :expenses
      get :revenues
      get :income_statements
      get :companies_index
      get :not_found
    end
  end
  resources :expenses do
    collection do
      post :registration
      post :update_amount
    end
  end
  resources :financings do
    collection do
      post :registration
      post :update_amount
    end
  end
  resources :models
  resources :investments do
    collection do
      post :registration
      post :update_amount
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
