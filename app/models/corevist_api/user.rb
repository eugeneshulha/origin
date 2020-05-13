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
    PAYER_FUNCTION = 'RG'.freeze

    def assigned_partners
      partners.where(assigned: true)
    end

    def sold_tos
      partners.where(function: SOLD_TO_FUNCTION, assigned: true)
    end

    def ship_tos
      partners.where(function: SHIP_TO_FUNCTION, assigned: true)
    end

    def payers
      partners.where(function: PAYER_FUNCTION, assigned: true)
    end

    alias assigned_sold_tos sold_tos
    alias assigned_ship_tos ship_tos
    alias assigned_payers payers


    def customer_admin?
      user_type.title == TYPE_CUSTOMER_ADMIN
    end

    def system_admin?
      user_type.value == 'S'
    end

    # FI-authorization flag: N = none, I = invoices, O = open items, B = both invoices and open items
    def fi_authorizations
      'B'
    end

    def sales_areas_titles
      microsite.sales_areas.pluck(:title)
    end

    def doc_categories_by_sales_area(sales_area)
      microsite.sales_areas.find_by_title(sales_area)&.doc_categories&.uniq&.pluck(:id)
    end

    def self.extra_column_names
      super << 'password'
    end

    def as_json(options = nil)
      relations = self.class.reflections.keys.each_with_object({}) { |relation, memo| memo[relation] = send(relation) }
      relations = relations.except('partners')
      partners_brake_down = { sold_tos: sold_tos, ship_tos: ship_tos, payers: payers }
      relations.merge!(partners_brake_down)
      attributes.merge(relations)
    end

    def self.find_by_id(id)
      find_by(id: id) || find_by(uuid: id)
    end

    def number_format
      @number_format || Settings.number_format_US
    end

    def date_format
      @date_format || Settings.date_format_US
    end

    def authorized_for?(privilege)
      roles.any? { |role| role.permissions.pluck(:title).include?(privilege) }
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
