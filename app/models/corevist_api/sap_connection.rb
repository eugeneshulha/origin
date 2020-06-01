module CorevistAPI
  class SAPConnection < ApplicationRecord
    self.table_name = 'sap_connections'

    scope :current, -> { where(active: true) }
  end
end
