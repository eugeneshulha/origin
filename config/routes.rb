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

      # registrations
      resources :registrations, only: [:new, :create]

      resources :invoices, only: [:new, :show, :index], param: :doc_number do
        resources :items, only: [:index], controller: 'invoices/items'
        resources :output_types, only: [:index, :show], param: :output_type_id, controller: 'invoices/output_types'
      end

      resources :salesdocs, only: [:new, :show, :index], param: :doc_number do
        resources :items, only: [:index], controller: 'salesdocs/items'
        resources :output_types, only: [:index, :show], param: :output_type_id, controller: 'salesdocs/output_types'
      end

      get 'status', to: 'statuses#status'

      # admin panel
      namespace :admin do
        resources :users, param: :uuid do
          get 'new', on: :collection

          resources :partners, only: %i[index], controller: 'users/partners'
        end

        resources :roles
      end

      resources :partners, only: %i[index new]
      resources :summaries, only: [] do
        collection do
          get :salesdocs, to: 'summaries/salesdocs#index'
        end
      end
      resources :open_items, only: :index
    end
  end

  get '*unmatched_route', to: 'api/base#not_found'
end
