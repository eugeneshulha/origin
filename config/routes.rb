CorevistAPI::Engine.routes.draw do

    devise_for :users, class_name: "CorevistAPI::User", module: :devise, defaults: { format: :json },
               path: 'api/v1/',
               path_names: { sign_in: :auth, sign_out: :logout
              },
              controllers: { sessions: 'corevist_a_p_i/api/v1/sessions' }
end
