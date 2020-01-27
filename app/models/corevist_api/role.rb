module CorevistAPI
  class Role < ApplicationRecord
    self.table_name = 'roles'

    belongs_to :user, required: false
  end
end
