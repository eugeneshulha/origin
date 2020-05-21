module CorevistAPI
  class Role < ApplicationRecord
    self.table_name = 'roles'

    has_and_belongs_to_many :users
    has_and_belongs_to_many :permissions

    validates_uniqueness_of :title
    validates_presence_of :title
    validates_presence_of :description

    def to_s
      title
    end
  end
end
