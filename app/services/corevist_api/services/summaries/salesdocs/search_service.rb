module CorevistAPI
  module Services
    class Summaries::Salesdocs::SearchService< CorevistAPI::Services::BaseServiceWithForm
      def perform
        rfc_result = rfc_service_for(:summary, @form, @params).call
        result(rfc_result.data[:summarized_salesdocs])
      end
    end
  end
end
