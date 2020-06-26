module CorevistAPI
  class Cart::Item < ApplicationRecord
    self.table_name = 'cart_items'

    include CorevistAPI::UserTrackable

    belongs_to :cart, primary_key: :uuid, foreign_key: :cart_uuid
  end
end
