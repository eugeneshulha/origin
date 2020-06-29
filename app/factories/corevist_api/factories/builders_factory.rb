module CorevistAPI
  module Factories
    class BuildersFactory < BaseFactory
      def initialize
        @storage = {
          partner: 'CorevistAPI::Builders::PartnerBuilder',
          salesdoc: 'CorevistAPI::Builders::SalesdocBuilder',
          invoice: 'CorevistAPI::Builders::InvoiceBuilder',
          payment: 'CorevistAPI::Builders::PaymentBuilder'
        }
      end
    end
  end
end
