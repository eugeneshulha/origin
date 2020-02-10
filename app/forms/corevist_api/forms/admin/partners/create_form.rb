module CorevistAPI
  module Forms
    class Admin::Partners::CreateForm < BaseForm
      include VariablesNames

      validates_presence_of(*permitted_params)

      def self.permitted_params
        super + %w[user_uuid partner_number]
      end
    end
  end
end
