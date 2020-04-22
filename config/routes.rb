CorevistAPI::Engine.routes.draw do
  scope :api, defaults: { format: :json } do
    scope :v1 do
      devise_for :users, class_name: "CorevistAPI::User", module: :devise, singular: :user,
                 path: '',
                 controllers: {
                     sessions: 'corevist_api/api/v1/sessions',
                     passwords: 'corevist_api/api/v1/passwords'
                 }
      as :user do
        post 'auth',    to: 'api/v1/sessions#create'
        get 'auth/new', to: 'api/v1/sessions#new'
        delete 'logout',       to: 'api/v1/sessions#destroy'
      end
    end
  end

  namespace :api do
    namespace :v1 do

      resources :users, only: [], param: :uuid do
        resources :partners, only: %i[index], controller: 'users/partners'
      end

      resources :account_details, only: [:show], param: :user_id
      resources :accounts, only: [:show], param: :user_id

      resources :payments, only: [:new, :create]
      resource :dashboard, only: [:new]

      # registrations
      resources :registrations, only: [:new, :create]

      resources :invoices, only: [:new, :show, :index], param: :doc_number do
        get :configs, on: :collection, to: 'invoices#index_configs'
        get 'filters/new', on: :collection, to: 'invoices/filters#new'
        resources :items, only: [:index], controller: 'invoices/items'
        resources :questions, only: [:new, :create], controller: 'invoices/questions'
        resources :output_types, only: [:index, :show], param: :output_type_id, controller: 'invoices/output_types'
      end

      resources :salesdocs, only: [:new, :show, :index], param: :doc_number do
        get :configs, on: :collection, to: 'salesdocs#index_configs'
        get 'filters/new', on: :collection, to: 'salesdocs/filters#new'
        resources :items, only: [:index], controller: 'salesdocs/items'
        resources :questions, only: [:new, :create], controller: 'salesdocs/questions'
        resources :output_types, only: [:index, :show], param: :output_type_id, controller: 'salesdocs/output_types'
      end

      get 'status', to: 'statuses#status'

      # admin panel
      namespace :admin do
        resources :users, only: [:index, :new, :create, :edit, :update, :show, :destroy], param: :uuid do
          get :configs, on: :collection, to: 'users#index_configs'
          get :configs, on: :member, to: 'users#show_configs'
          get 'filters/new', on: :collection, to: 'users/filters#new'
          resources :partners, only: %i[index destroy], controller: 'users/partners'
        end

        resources :roles, only: [:index, :new, :create, :edit, :update, :show, :destroy], param: :uuid do
          get :configs, on: :collection, to: 'roles#index_configs'
          get :configs, on: :member, to: 'roles#show_configs'
        end

        resources :translations, only: [:index, :new, :create, :edit, :update, :destroy] do
          get :configs, on: :collection, to: 'translations#index_configs'
          get 'filters/new', on: :collection, to: 'translations/filters#new'
        end
      end

      resources :partners, only: %i[index] do
        get 'filters/new', on: :collection, to: 'partners/filters#new'
        get 'filters/configs', on: :collection, to: 'partners/filters#index_configs'
      end
      resources :open_items, only: :index

      resources :site_configs, only: [:index]
    end
  end

  get '*unmatched_route', to: 'api/base#not_found'
end
