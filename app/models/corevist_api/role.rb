module CorevistAPI
  class Role < ApplicationRecord
    self.table_name = 'roles'

    has_and_belongs_to_many :users
    has_and_belongs_to_many :permissions, -> { distinct }

    validates_uniqueness_of :title
    validates_presence_of :title

    def as_json(*_args)
      super.merge!(permissions: permissions.to_a)
    end
    
    def to_s
      title
    end
    
    def self.extra_column_names
      super << 'permission_ids'
    end
  end
end
