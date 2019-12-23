module CorevistAPI
  class User < ApplicationRecord
    devise :database_authenticatable,
           :jwt_authenticatable, jwt_revocation_strategy: JWTBlacklist

    self.table_name = 'users'
  end
end
