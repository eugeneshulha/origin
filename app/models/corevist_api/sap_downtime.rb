module CorevistAPI
  class SAPDowntime < ApplicationRecord
    include CorevistAPI::FormatConversion
    include CorevistAPI::UserTrackable

    self.table_name = 'sap_downtimes'
    format_date :down_from_date, :down_to_date
    format_time :down_from_time, :down_to_time
    format_datetime :created_at, :updated_at

    def self.current
      str = ":date >= down_from_date AND :date <= down_to_date AND :time >= down_from_time AND :time <= down_to_time AND active=true"
      date = Time.zone.now.to_date
      time = Time.zone.now.to_time
      CorevistAPI::SAPDowntime.where(str, date: date, time: time).first
    end
  end
end
