module CorevistAPI
  class User < ApplicationRecord
    devise :database_authenticatable, :recoverable, :jwt_authenticatable, jwt_revocation_strategy: JWTBlacklist

    self.table_name = 'users'

    has_many :partners
    has_and_belongs_to_many :roles
    belongs_to :user_type
    belongs_to :user_classification
    belongs_to :microsite

    before_create :set_uuid

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
