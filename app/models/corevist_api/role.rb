module CorevistAPI
  class Role < ApplicationRecord
    self.table_name = 'roles'

    has_and_belongs_to_many :users
    has_and_belongs_to_many :sales_areas
  end
end
