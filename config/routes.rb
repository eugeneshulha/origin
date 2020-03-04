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

      resources :invoices, only: [:show, :index], param: :doc_number
      resources :salesdocs, only: [:show, :index], param: :doc_number

      get 'status', to: 'statuses#status'

      # admin panel
      namespace :admin do
        resources :users, except: %i[new edit] do
          resources :partners, only: %i[index], controller: 'users/partners'
        end

        resources :roles
      end

      resources :partners, only: %i[index]
      resources :summaries, only: [] do
        collection do
          get :salesdocs, to: 'summaries/salesdocs#index'
        end
      end
      resources :open_items, only: :index
    end
  end
end
