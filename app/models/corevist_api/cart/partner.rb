module CorevistAPI
  class Cart::Partner < ApplicationRecord
    self.table_name = 'cart_partners'

    include CorevistAPI::UserTrackable

    belongs_to :cart, primary_key: :uuid, foreign_key: :cart_uuid
  end
end
