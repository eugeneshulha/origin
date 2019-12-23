CorevistAPI::Engine.routes.draw do

  namespace :api do
    namespace :v1 do
      devise_for :users, class_name: "CorevistAPI::User", module: :devise, defaults: { format: :json }
    end
  end
end
