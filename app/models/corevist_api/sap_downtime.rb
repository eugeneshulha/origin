module CorevistAPI
  class SAPDowntime < ApplicationRecord
    include CorevistAPI::FormatConversion
    include CorevistAPI::UserTrackable

    self.table_name = 'sap_downtimes'
    format_date :down_from, :down_to
  end
end
