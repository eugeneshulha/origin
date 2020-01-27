module CorevistAPI
  class User < ApplicationRecord
    devise :database_authenticatable, :recoverable, :jwt_authenticatable, jwt_revocation_strategy: JWTBlacklist

    has_many :assigned_partners
    has_many :roles

    before_create :set_uuid

    self.table_name = 'users'

    TYPE_CUSTOMER_ADMIN = 'customer_admin'.freeze
    TYPE_SYSTEM_ADMIN = 'system_admin'.freeze
    SOLD_TO_FUNCTION = 'AG'.freeze
    SHIP_TO_FUNCTION = 'WE'.freeze


    def sold_tos
      assigned_partners.where(function: SOLD_TO_FUNCTION)
    end

    def ship_tos
      assigned_partners.where(function: SHIP_TO_FUNCTION)
    end

    alias assigned_sold_tos sold_tos
    alias assigned_ship_tos ship_tos

    def customer_admin?
      user_type == TYPE_CUSTOMER_ADMIN
    end

    def system_admin?
      user_type == TYPE_SYSTEM_ADMIN
    end

    private

    def set_uuid
      self.uuid = SecureRandom.uuid
    end
  end
end
