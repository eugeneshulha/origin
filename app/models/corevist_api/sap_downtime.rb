module CorevistAPI
  class SAPDowntime < ApplicationRecord
    include CorevistAPI::FormatConversion
    include CorevistAPI::UserTrackable

    self.table_name = 'sap_downtimes'
    format_date :down_from, :down_to

    def self.current
      str = ":date >= down_from_date AND :date <= down_to_date AND :time >= down_from_time AND :time <= down_to_time AND active=true"
      date = Time.zone.now.to_date
      time = Time.zone.now.to_time
      CorevistAPI::SAPDowntime.where(str, date: date, time: time).first
    end

    def down_to_time
      t_format = CorevistAPI::Context.current_user.time_format
      self.read_attribute(:down_to_time)&.strftime(t_format)
    end

    def down_from_time
      t_format = CorevistAPI::Context.current_user.time_format
      self.read_attribute(:down_from_time)&.strftime(t_format)
    end
    #
    # def down_to_date
    #   d_format = CorevistAPI::Context.current_user.date_format
    #   self.read_attribute(:down_to_date)&.strftime(d_format)
    # end
    #
    # def down_from_date
    #   d_format = CorevistAPI::Context.current_user.date_format
    #   self.read_attribute(:down_from_date)&.strftime(d_format)
    # end
  end
end
