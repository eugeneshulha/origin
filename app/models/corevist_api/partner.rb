module CorevistAPI
  class Partner < ApplicationRecord
    self.table_name = 'partners'

    belongs_to :user
    belongs_to :sales_area

    # self association
    has_many :associated_partners, class_name: 'Partner', foreign_key: 'parent_partner_id', dependent: :destroy
    belongs_to :parent_partner, class_name: 'Partner', optional: true
  end
end
