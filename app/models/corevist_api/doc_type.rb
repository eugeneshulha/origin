module CorevistAPI
  class DocType < ApplicationRecord
    self.table_name = 'doc_types'

    include CorevistAPI::UserTrackable

    has_and_belongs_to_many :sales_areas

    def as_json(*_args)
      {}.tap { |hash| %i[id title description data].map { |key| hash[key] = send(key) } }
    end
  end
end
