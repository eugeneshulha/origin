module CorevistAPI
  class JWTBlacklist < ApplicationRecord
    include Devise::JWT::RevocationStrategies::Blacklist

    self.table_name = 'jwt_blacklist'

    def self.invalidate_token(token)
      transaction do
        create(jti: token.access_jti, exp: token.access_exp)
        create(jti: token.refresh_jti, exp: token.refresh_exp)
        token.destroy
      end
    end
  end
end
