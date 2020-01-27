module CorevistAPI
  class AssignedPartner < ApplicationRecord
    self.table_name = 'assigned_partners'

    belongs_to :user
  end
end
