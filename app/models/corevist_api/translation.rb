module CorevistAPI
  class Translation < ApplicationRecord
    self.table_name = :translations

    include CorevistAPI::Translations::Base::Model
  end
end
