module CorevistAPI
  class Translation < ApplicationRecord
    self.table_name = :translations

    include CorevistAPI::UserTrackable
    include CorevistAPI::Translations::Base::Model

    belongs_to :microsite, optional: true
  end
end
