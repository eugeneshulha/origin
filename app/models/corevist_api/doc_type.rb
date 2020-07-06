module CorevistAPI
  class DocType < ApplicationRecord
    self.table_name = 'doc_types'

    include CorevistAPI::UserTrackable

    has_and_belongs_to_many :sales_areas
  end
end
