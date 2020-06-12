module CorevistAPI
  class DocCategory < ApplicationRecord
    self.table_name = 'doc_categories'

    include CorevistAPI::UserTrackable

    has_and_belongs_to_many :sales_areas

    def as_json(*_args)
      {}.tap { |hash| %i[id title description].map { |key| hash[key] = send(key) } }
    end
  end
end
