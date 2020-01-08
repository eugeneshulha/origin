module CorevistAPI
  class User < ApplicationRecord
    devise :database_authenticatable, :jwt_authenticatable, jwt_revocation_strategy: JWTBlacklist
    # devise :database_authenticatable

    before_save :set_uuid

    self.table_name = 'users'

    private

    def set_uuid
      self.uuid = SecureRandom.uuid
    end
  end
end
