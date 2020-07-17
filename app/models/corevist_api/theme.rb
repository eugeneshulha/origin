module CorevistAPI
  class Theme < ApplicationRecord
    self.table_name = 'themes'

    has_many :configurations

    validates_uniqueness_of :title
  end
end
