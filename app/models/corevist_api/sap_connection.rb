module CorevistAPI
  class SAPConnection < ApplicationRecord
    self.table_name = 'sap_connections'
    enum env: [:development, :qa, :test, :production]

    scope :current, -> { where(active: true) }

    before_save :deactivate_the_rest

    private

    def deactivate_the_rest
      if self.active?
        # deactivate connections for self.env without self
        records = self.class.where(env: self.env).where.not(id: self.id)
        records.update(active: false)
      end
    end
  end
end
