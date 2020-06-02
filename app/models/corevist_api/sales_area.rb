module CorevistAPI
  class SalesArea < ApplicationRecord
    self.table_name = 'sales_areas'

    has_many :partners
    has_and_belongs_to_many :microsites
    has_and_belongs_to_many :doc_categories
    has_and_belongs_to_many :doc_types

    attr_accessor :selected

    def selected?
      !!selected
    end

    def as_json(*_args)
      {}.tap { |hash| %i[id title description selected].map { |key| hash[key] = send(key) } }
    end

    def self.extra_column_names
      super << 'doc_type_ids' << 'doc_category_ids'
    end

    def doc_types_list
      assigned = doc_types.to_a
      CorevistAPI::DocType.all.each { |p| p.selected = assigned.include?(p) }.map(&:to_json)
    end

    def doc_categories_list
      assigned = doc_categories.to_a
      CorevistAPI::DocCategory.all.each { |p| p.selected = assigned.include?(p) }.map(&:to_json)
    end
  end
end
