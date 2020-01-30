module CorevistAPI
  class DocCategory < ApplicationRecord
    self.table_name = 'doc_categories'

    has_and_belongs_to_many :sales_areas
  end
end
