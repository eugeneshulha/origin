module CorevistAPI
  class Cart::Extension < ApplicationRecord
    self.table_name = 'cart_extensions'

    include CorevistAPI::UserTrackable

    belongs_to :cart, primary_key: :uuid, foreign_key: :cart_uuid
  end
end
