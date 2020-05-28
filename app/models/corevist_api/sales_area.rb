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

    def to_json(*_args)
      {}.tap { |hash| %i[id title description selected].map { |key| hash[key] = send(key) } }
    end
  end
end
