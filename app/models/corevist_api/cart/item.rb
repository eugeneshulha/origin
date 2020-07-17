module CorevistAPI
  class Cart::Item < ApplicationRecord
    self.table_name = 'cart_items'
    include CorevistAPI::FormatConversion
    include CorevistAPI::UserTrackable

    belongs_to :cart, primary_key: :uuid, foreign_key: :cart_uuid

    before_create :set_id

    private

    def set_id
      self.id = SecureRandom.uuid
    end
  end
end
