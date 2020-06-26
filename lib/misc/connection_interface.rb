module CorevistAPI
  module ConnectionInterface
    def is_sap_down?
      CorevistAPI::SAPDowntime.current.present?
    end

    def is_sap_up?
      !is_sap_down?
    end
  end
end
