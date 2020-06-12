module CorevistAPI
  class SAPConnection < ApplicationRecord
    self.table_name = 'sap_connections'
    enum env: [:development, :qa, :test, :production]

    include CorevistAPI::UserTrackable

    scope :current, -> { where(active: true, env: Rails.env) }

    before_save :deactivate_the_rest
    validates :title, uniqueness: { scope: :env,  message: N_('error|attributes.title.not_uniq') }

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
