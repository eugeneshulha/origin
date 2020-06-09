module CorevistAPI
  module ConnectionInterface
    def is_sap_down?
      CorevistAPI::SAPDowntime.where(":date >= down_from AND :date <= down_to AND active=true", date: Time.zone.now).any?
    end

    def is_sap_up?
      !is_sap_down?
    end
  end
end
