module CorevistAPI
  class SalesArea < ApplicationRecord
    default_scope { includes(:doc_types, :doc_categories) }

    self.table_name = 'sales_areas'

    has_many :partners
    has_and_belongs_to_many :microsites
    has_and_belongs_to_many :doc_categories
    has_and_belongs_to_many :doc_types

    validates :title, uniqueness: { message: N_('error|attributes.name.not_uniq') }

    def as_json(*_args)
      super.tap { |hash| %i[doc_types doc_categories ].map { |key| hash[key] = send(key) } }
    end

    def self.extra_column_names
      super << 'doc_type_ids' << 'doc_category_ids'
    end
  end
end
