module CorevistAPI
  class Microsite < ApplicationRecord
    self.table_name = 'microsites'

    validates_presence_of :name
  end
end
