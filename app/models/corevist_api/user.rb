module CorevistAPI
  class User < ApplicationRecord
    attr_reader :access_exp, :refresh_exp, :token

    devise :database_authenticatable, :recoverable, :jwt_authenticatable, jwt_revocation_strategy: JWTBlacklist

    self.table_name = 'users'

    has_many :partners
    has_and_belongs_to_many :roles, before_add: :check_roles
    has_and_belongs_to_many :assignable_roles,
                            before_add: :check_assignable_roles,
                            join_table: 'assignable_roles_users',
                            association_foreign_key: 'role_id'
    has_many :jwt_tokens, dependent: :destroy
    belongs_to :user_type
    belongs_to :user_classification, optional: true
    belongs_to :microsite

    before_create :set_uuid

    validates_uniqueness_of :username

    KEY_EXP             = 'exp'.freeze
    KEY_JTI             = 'jti'.freeze
    KEY_SUB             = 'sub'.freeze
    PAYER_FUNCTION      = 'RG'.freeze
    SHIP_TO_FUNCTION    = 'WE'.freeze
    SOLD_TO_FUNCTION    = 'AG'.freeze
    TYPE_CUSTOMER_ADMIN = 'customer_admin'.freeze
    TYPE_SYSTEM_ADMIN   = 'system_admin'.freeze

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
      roles.flat_map { |role| role.sales_areas.pluck(:title) }
    end

    def doc_categories_by_sales_area(sales_area)
      roles.flat_map { |role| role.sales_areas.find_by_title(sales_area).doc_categories.uniq.pluck(:id) }
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

    def on_jwt_dispatch(_, payload)
      @token, refresh_payload = refresh_token
      jwt_tokens.create(
        access_jti: payload[KEY_JTI],
        access_exp: @access_exp = utc_time(payload[KEY_EXP]),
        refresh_jti: refresh_payload[KEY_JTI],
        refresh_exp: @refresh_exp = utc_time(refresh_payload[KEY_EXP])
      )
    end

    def refresh_token
      payload = {
        KEY_EXP => Time.now.utc.to_i + Settings.dig(:jwt, :refresh_exp_time),
        KEY_SUB => id,
        scope: :user,
        KEY_JTI => SecureRandom.uuid
      }
      token = Warden::JWTAuth::TokenEncoder.new.call(payload)
      [token, payload]
    end

    def jwt_data
      {
        account_id: uuid,
        refresh_token: token,
        refresh_exp: refresh_exp.to_i,
        access_exp: access_exp.to_i
      }
    end

    def warden_options
      { scope: :user, store: true, event: :authentication, run_callbacks: true }
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

    def utc_time(timestamp)
      Time.at(timestamp).utc
    end
  end
end
