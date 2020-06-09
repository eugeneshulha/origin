module CorevistAPI
  class DocCategory < ApplicationRecord
    self.table_name = 'doc_categories'

    has_and_belongs_to_many :sales_areas

    attr_accessor :selected

    def selected?
      !!selected
    end

    def as_json(*_args)
      {}.tap { |hash| %i[id title description selected].map { |key| hash[key] = send(key) } }
    end
  end
end
