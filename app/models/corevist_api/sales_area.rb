module CorevistAPI
  class SalesArea < ApplicationRecord
    self.table_name = 'sales_areas'

    has_many :partners
    has_and_belongs_to_many :microsites
    has_and_belongs_to_many :doc_categories
    has_and_belongs_to_many :doc_types

    validates :title, uniqueness: { message: N_('error|attributes.name.not_uniq') }

    attr_accessor :selected

    def selected?
      !!selected
    end

    def as_json(*_args)
      {}.tap { |hash| %i[id title description selected doc_types doc_categories].map { |key| hash[key] = send(key) } }
    end

    def self.extra_column_names
      super << 'doc_type_ids' << 'doc_category_ids'
    end
  end
end
