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
        post 'auth',               to: 'api/v1/sessions#create'
        get 'auth/new',            to: 'api/v1/sessions#new'
        delete 'logout',           to: 'api/v1/sessions#destroy'
        post 'auth/refresh_token', to: 'api/v1/sessions#refresh_token'
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

      resource :dashboard, only: %i[new] do
        get :navigation, to: 'dashboards#navigation'
      end

      # registrations
      resources :registrations, only: %i[new create]

      #
      # TODO: payments/invoices/salesdocs should be refactored!!
      #
      resources :invoices, only: %i[show index], param: :doc_number do
        get :configs, on: :collection, to: 'invoices#index_configs'
        get :configs, on: :member, to: 'invoices#show_configs'
        get 'filters/new', on: :collection, to: 'invoices/filters#new'
        post :download, to: 'invoices#download', on: :collection

        resources :items, only: [:index], controller: 'invoices/items' do
          post :download, to: 'invoices/items#download', on: :collection
        end
        resources :questions, only: %i[new create], controller: 'invoices/questions'
        resources :output_types, only: %i[index show], param: :output_type_id, controller: 'invoices/output_types'
      end

      resources :salesdocs, only: %i[show index], param: :doc_number do
        get :configs, on: :collection, to: 'salesdocs#index_configs'
        get :configs, on: :member, to: 'salesdocs#show_configs'
        get 'filters/new', on: :collection, to: 'salesdocs/filters#new'
        post :download, to: 'salesdocs#download', on: :collection

        resources :items, only: [:index], controller: 'salesdocs/items' do
          post :download, to: 'salesdocs/items#download', on: :collection
        end
        resources :questions, only: %i[new create], controller: 'salesdocs/questions'
        resources :output_types, only: %i[index show], param: :output_type_id, controller: 'salesdocs/output_types'
      end

      resources :payments, only: %i[show index], param: :doc_number do
        get :configs, on: :collection, to: 'payments#index_configs'
        get :configs, on: :member, to: 'payments#show_configs'
        get 'filters/new', on: :collection, to: 'payments/filters#new'
        post :download, to: 'payments#download', on: :collection

        resources :items, only: [:index], controller: 'payments/items' do
          post :download, to: 'payments/items#download', on: :collection
        end
        resources :questions, only: %i[new create], controller: 'payments/questions'
        resources :output_types, only: %i[index show], param: :output_type_id, controller: 'payments/output_types'
      end

      get 'status', to: 'statuses#status'

      # admin panel
      namespace :admin do
        resources :users, only: %i[index new create edit update show destroy], param: :uuid do
          post :download, to: 'users#download', on: :collection
          get :configs, on: :collection, to: 'users#index_configs'
          get :configs, on: :member, to: 'users#show_configs'
          get 'filters/new', on: :collection, to: 'users/filters#new'
          resources :partners, only: %i[index destroy], controller: 'users/partners'
        end

        resources :roles, only: %i[index new create update show destroy], param: :uuid do
          get :configs, on: :collection, to: 'roles#index_configs'
          get :configs, on: :member, to: 'roles#edit'
        end

        resources :permissions, only: %i[index]

        resources :translations, only: %i[index new create update edit destroy], param: :uuid do
          get :configs, on: :collection, to: 'translations#index_configs'
          get :configs, on: :member, to: 'translations#edit'
          get 'filters/new', on: :collection, to: 'translations/filters#new'
        end

        namespace :system_settings do
          resources :microsites, only: %i[index new create update show destroy], param: :uuid do
            get :configs, on: :collection, to: 'microsites#index_configs'
            get :configs, on: :member, to: 'microsites#edit'
          end

          resources :sales_areas, only: %i[index new create update show destroy], param: :uuid do
            get :configs, on: :collection, to: 'sales_areas#index_configs'
            get :configs, on: :member, to: 'sales_areas#edit'
          end

          resources :doc_types, only: %i[index new create edit update show destroy], param: :uuid do
            get :configs, on: :collection, to: 'doc_types#index_configs'
            get :configs, on: :member, to: 'doc_types#edit'
          end

          resources :doc_categories, only: %i[index], param: :uuid do
            get :configs, on: :collection, to: 'doc_categories#index_configs'
          end

          resources :sap_maintenance, only: [] do
            get :configs, on: :collection, to: 'sap_maintenance#index_configs'
          end

          namespace :sap_maintenance do
            resources :sap_connections, only: %i[index new create update show destroy], param: :uuid do
              get :configs, on: :collection, to: 'sap_connections#index_configs'
              get :configs, on: :member, to: 'sap_connections#edit'
              get :ping, on: :member, to: 'sap_connections#ping'
            end

            resources :sap_downtimes, only: %i[index new create update show destroy], param: :uuid do
              get :configs, on: :collection, to: 'sap_downtimes#index_configs'
              get :configs, on: :member, to: 'sap_downtimes#edit'
            end
          end
        end
      end

      resources :partners, only: %i[index] do
        get 'filters/new', on: :collection, to: 'partners/filters#new'
        get 'filters/configs', on: :collection, to: 'partners/filters#index_configs'
      end

      resources :open_items, only: [:index, :new, :create] do
        get :configs, on: :collection, to: 'open_items#index_configs'
        get :configs, on: :member, to: 'open_items#show_configs'

        resources :payment_methods, only: %i[new]
      end

      resources :site_configs, only: [:index]

      scope :cart do
        post :simulate, to: 'carts#simulate'
        post :create, to: 'carts#create'
      end
    end
  end

  get '*unmatched_route', to: 'api/base#not_found'
end
