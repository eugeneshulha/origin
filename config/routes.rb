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
      devise_scope :user do
        get 'auth/configs', to: 'sessions#configs'
      end

      # registrations
      resources :registrations, only: [:new, :create]

      resources :invoices, only: [:show, :index], param: :doc_number do
        resources :items, on: :member, only: [:index], controller: 'invoices/items'
      end

      resources :salesdocs, only: [:new, :show, :index], param: :doc_number do
        resources :items, on: :member, only: [:index], controller: 'salesdocs/items'
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
