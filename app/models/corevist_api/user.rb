module CorevistAPI
  class User < ApplicationRecord
    devise :database_authenticatable, :recoverable, :jwt_authenticatable, jwt_revocation_strategy: JWTBlacklist

    before_create :set_uuid

    self.table_name = 'users'

    def self.policy_class
      API::V1::Admin::UserPolicy
    end

    private

    def set_uuid
      self.uuid = SecureRandom.uuid
    end
  end
end
