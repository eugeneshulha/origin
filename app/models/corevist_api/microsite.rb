module CorevistAPI
  class Microsite < ApplicationRecord
    self.table_name = 'microsites'

    has_and_belongs_to_many :territories, before_add: :check_territories
    has_and_belongs_to_many :sales_areas
    has_many :users

    validates_presence_of :name

    def self.extra_column_names
      super << 'sales_area_ids'
    end

    def as_json(*_args)
      super.merge!(sales_areas: sales_areas.to_a)
    end
    
    def to_s
      name
    end

    def created_by
      CorevistAPI::User.find_by(id: self.read_attribute(:created_by))&.name || self.read_attribute(:created_by)
    end

    def updated_by
      CorevistAPI::User.find_by(id: self.read_attribute(:updated_by))&.name || self.read_attribute(:updated_by)
    end

    private

    def check_territories(territory)
      raise ActiveRecord::Rollback if territories.include?(territory)
    end
  end
end
