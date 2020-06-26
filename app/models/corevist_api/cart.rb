module CorevistAPI
  class Cart < ApplicationRecord
    self.table_name = 'carts'
    self.primary_key = 'uuid'

    include CorevistAPI::UserTrackable

    enum customer_material: %w[F T]
    enum price_print_flag: %w[K P V]

    belongs_to :user
    has_many :items, class_name: 'CorevistAPI::Cart::Item', foreign_key: :cart_uuid
    has_many :partners, class_name: 'CorevistAPI::Cart::Partner', foreign_key: :cart_uuid
    has_many :extensions, class_name: 'CorevistAPI::Cart::Extension', foreign_key: :cart_uuid

    validates_uniqueness_of :title, scope: :user_id

    before_create :set_uuid
    before_save :deactivate_other_carts

    private

    def set_uuid
      self.uuid = SecureRandom.uuid
    end

    def deactivate_other_carts
      self.class.where(user: user, active: true).update(active: false) if active?
    end
  end
end
