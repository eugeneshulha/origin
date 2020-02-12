module CorevistAPI
  class Privilege < ApplicationRecord
    self.table_name = 'privileges'

    has_and_belongs_to_many :roles
  end
end
