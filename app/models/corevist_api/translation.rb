module CorevistAPI
  class Translation < ApplicationRecord
    self.table_name = :translations

    belongs_to :microsite, optional: true

    include CorevistAPI::Translations::Base::Model
  end
end
