module CorevistAPI
  module Filters::Links
    class MicrositeLink < BaseLink
      TYPE_CUSTOMER = 'customer'.freeze

      def perform(data)
        return unless !data.object.system_admin? && CorevistAPI::Microsite.count > 1

        data.query = data.query.where(microsite: data.object.microsite)
      end
    end
  end
end
