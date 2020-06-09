module CorevistAPI
  class Microsite < ApplicationRecord
    self.table_name = 'microsites'

    has_and_belongs_to_many :territories, before_add: :check_territories
    has_and_belongs_to_many :sales_areas

    validates_presence_of :name

    def sales_areas_list
      assigned = sales_areas.to_a
      CorevistAPI::SalesArea.all.each { |p| p.selected = assigned.include?(p) }.map(&:to_json)
    end

    def self.extra_column_names
      super << 'sales_area_ids'
    end

    def as_json(*_args)
      super.merge!(sales_areas: sales_areas.to_a)
    end
    
    def to_s
      name
    end

    private

    def check_territories(territory)
      raise ActiveRecord::Rollback if territories.include?(territory)
    end
  end
end
