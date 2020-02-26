module CorevistAPI
  class Role < ApplicationRecord
    self.table_name = 'roles'

    has_and_belongs_to_many :users
    has_and_belongs_to_many :sales_areas
    has_and_belongs_to_many :privileges

    validates_uniqueness_of :title
    validates_presence_of :title
    validates_presence_of :description
  end
end
