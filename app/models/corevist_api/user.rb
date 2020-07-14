module CorevistAPI
  class User < ApplicationRecord
    include CorevistAPI::Constants::Common

    attr_reader :access_exp, :refresh_exp, :token

    include CorevistAPI::UserTrackable

    devise :database_authenticatable, :recoverable, :jwt_authenticatable, jwt_revocation_strategy: JWTBlacklist

    self.table_name = 'users'

    has_many :partners
    has_and_belongs_to_many :roles, before_add: :check_roles
    has_and_belongs_to_many :assignable_roles,
                            before_add: :check_assignable_roles,
                            join_table: 'assignable_roles_users',
                            association_foreign_key: 'role_id'
    has_many :jwt_tokens, dependent: :destroy
    belongs_to :user_type, optional: true
    belongs_to :user_classification, optional: true
    belongs_to :microsite, optional: true
    has_many :carts, dependent: :destroy

    before_create :set_uuid
    before_save :populate_defaults

    validates_uniqueness_of :username

    KEY_EXP             = 'exp'.freeze
    KEY_JTI             = 'jti'.freeze
    KEY_SUB             = 'sub'.freeze

    def name
      first_name + ' ' + last_name
    end

    def assigned_partners
      partners.where(assigned: true)
    end

    def sold_tos
      partners.where(function: CorevistAPI::Constants::Common::SOLD_TO_FUNCTION, assigned: true)
    end

    def ship_tos
      partners.where(function: CorevistAPI::Constants::Common::SHIP_TO_FUNCTION, assigned: true)
    end

    def payers
      partners.where(function: CorevistAPI::Constants::Common::PAYER_FUNCTION, assigned: true)
    end

    alias assigned_sold_tos sold_tos
    alias assigned_ship_tos ship_tos
    alias assigned_payers payers


    def customer_admin?
      user_type.title == CorevistAPI::Constants::Common::USER_TYPE_CUSTOMER_ADMIN
    end

    def system_admin?
      user_type.title == CorevistAPI::Constants::Common::USER_TYPE_SYSTEM_ADMIN
    end

    def customer?
      user_type.title == CorevistAPI::Constants::Common::USER_TYPE_CUSTOMER
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

    def authorized_for?(privilege)
      permissions.include?(privilege)
    end

    def not_authorized_for?(privilege)
      !authorized_for?(privilege)
    end

    def permissions
      roles.where(active: true).map { |role| role.permissions.pluck(:title) }.flatten.uniq
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

    def last_active_cart
      carts.find_by(active: true)
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

    def populate_defaults
      self.number_format = Settings.number_formats.US if number_format.blank?
      self.date_format = Settings.date_formats.US if date_format.blank?
      self.time_format = Settings.time_formats.send("24h") if time_format.blank?
      self.language = 'en_US' if language.blank?
    end
  end
end
