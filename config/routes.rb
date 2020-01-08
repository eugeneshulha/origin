CorevistAPI::Engine.routes.draw do

  scope :api, defaults: { format: :json } do
    scope :v1 do
      devise_for :users, class_name: "CorevistAPI::User", module: :devise, singular: :api_user,
                 path: '',
                 path_names: { sign_in: :auth, sign_out: :logout },
                 controllers: { sessions: 'corevist_api/api/v1/sessions' }
    end
  end

  scope :web, defaults: { format: :html } do
    devise_for :users, class_name: "CorevistAPI::User", module: :devise, singular: :web_user,
               path: '',
               path_names: { sign_in: :sign_in, sign_out: :logout },
               controllers: { sessions: 'corevist_api/web/sessions' }


    root to: 'web/admin/dashboards#index'
  end

  namespace :web do
    namespace :admin do
      get 'dashboard', to: 'dashboards#index'
    end
  end
end
