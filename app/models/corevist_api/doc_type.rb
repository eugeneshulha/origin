module CorevistAPI
  class DocType < ApplicationRecord
    self.table_name = 'doc_types'

    has_and_belongs_to_many :sales_areas

    attr_accessor :selected

    def selected?
      !!selected
    end

    def to_json(*_args)
      {}.tap { |hash| %i[id title description data selected].map { |key| hash[key] = send(key) } }
    end
  end
end
