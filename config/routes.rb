CorevistAPI::Engine.routes.draw do

  scope :api, defaults: { format: :json } do
    scope :v1 do
      devise_for :users, class_name: "CorevistAPI::User", module: :devise, singular: :user,
                 path: '',
                 path_names: { sign_in: :auth, sign_out: :logout },
                 controllers: { sessions: 'corevist_api/api/v1/sessions' }
    end
  end


  namespace :api do
    namespace :v1 do
      namespace :admin do
        resources :users
      end
    end
  end
end
