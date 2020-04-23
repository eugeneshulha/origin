module CorevistAPI
  class Permission < ApplicationRecord
    self.table_name = 'permissions'

    has_and_belongs_to_many :roles
  end
end
