module CorevistAPI
  class User < ApplicationRecord
    devise :database_authenticatable, :recoverable, :jwt_authenticatable, jwt_revocation_strategy: JWTBlacklist

    self.table_name = 'users'

    has_many :partners
    has_and_belongs_to_many :roles, before_add: :check_roles
    has_and_belongs_to_many :assignable_roles,
                            before_add: :check_assignable_roles,
                            join_table: 'assignable_roles_users',
                            association_foreign_key: 'role_id'
    belongs_to :user_type
    belongs_to :user_classification, optional: true
    belongs_to :microsite

    before_create :set_uuid

    validates_uniqueness_of :username

    TYPE_CUSTOMER_ADMIN = 'customer_admin'.freeze
    TYPE_SYSTEM_ADMIN = 'system_admin'.freeze
    SOLD_TO_FUNCTION = 'AG'.freeze
    SHIP_TO_FUNCTION = 'WE'.freeze

    def sold_tos
      partners.where(function: SOLD_TO_FUNCTION)
    end

    def ship_tos
      partners.where(function: SHIP_TO_FUNCTION)
    end

    alias assigned_sold_tos sold_tos
    alias assigned_ship_tos ship_tos

    def customer_admin?
      user_type == TYPE_CUSTOMER_ADMIN
    end

    def system_admin?
      user_type == TYPE_SYSTEM_ADMIN
    end

    # FI-authorization flag: N = none, I = invoices, O = open items, B = both invoices and open items
    def fi_authorizations
      'B'
    end

    def sales_areas_titles
      roles.flat_map { |role| role.sales_areas.pluck(:title) }
    end

    def doc_categories_by_sales_area(sales_area)
      roles.flat_map { |role| role.sales_areas.find_by_title(sales_area).doc_categories.uniq.pluck(:id) }
    end

    def self.extra_column_names
      super << 'password'
    end

    private

    def set_uuid
      self.uuid = SecureRandom.uuid
    end

    def check_roles(role)
      raise ActiveRecord::Rollback if roles.include?(role)
    end

    def check_assignable_roles(role)
      raise ActiveRecord::Rollback if assignable_roles.include?(role)
    end
  end
end
