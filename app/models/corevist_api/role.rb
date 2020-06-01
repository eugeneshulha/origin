module CorevistAPI
  class Role < ApplicationRecord
    self.table_name = 'roles'

    has_and_belongs_to_many :users
    has_and_belongs_to_many :permissions, -> { distinct }

    validates_uniqueness_of :title
    validates_presence_of :title

    def permissions_list
      assigned = permissions.to_a
      CorevistAPI::Permission.all.each { |p| p.active = assigned.include?(p) }.map(&:to_json)
    end

    def to_json(*_args)
      super.merge!(permissions: permissions.to_a)
    end

    def self.extra_column_names
      super << 'permission_ids'
    end
  end
end
