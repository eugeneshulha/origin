CorevistAPI::Engine.routes.draw do

  scope :api, defaults: { format: :json } do
    scope :v1 do
      devise_for :users, class_name: "CorevistAPI::User", module: :devise, singular: :user,
                 path: '',
                 path_names: {
                     sign_in: :auth,
                     sign_out: :logout,
                     password: :forgot_password
                 },
                 controllers: {
                     sessions: 'corevist_api/api/v1/sessions',
                     passwords: 'corevist_api/api/v1/passwords'
                 }
    end
  end

  namespace :api do
    namespace :v1 do
      devise_scope :user do
        get 'auth/configs', to: 'sessions#configs'
        get 'passwords/configs', to: 'passwords#configs'
      end

      # registrations
      resources :registrations, only: [:new, :create] do
        get :configs, to: 'registrations#configs', on: :collection
      end

      resources :invoices, only: :show do
        get :search, to: 'invoices#index'
      end

      resources :salesdocs, only: :show do
        get :search, to: 'salesdocs#index'
      end

      # admin panel
      namespace :admin do
        resources :users, param: :uuid do
          resources :partners, only: %i[index create], controller: 'users/partners'
        end

        resources :roles

        resources :partners, only: %i[index]
      end
    end
  end
end
