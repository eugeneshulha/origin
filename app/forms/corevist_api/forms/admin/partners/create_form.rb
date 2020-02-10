module CorevistAPI
  module Forms
    class Admin::Partners::CreateForm < BaseForm
      validate :presence_of_attributes
      validates_inclusion_of :function, in: %w[AG WE ag we], if: -> { respond_to?(:function) }

      def permitted_params
        super + %w[user_uuid partner_number function]
      end

      def presence_of_attributes
        permitted_params.each do |param|
          validates_presence_of(param) && next if respond_to?(param)

          errors.add(param, I18n.t("api.forms.create.#{param}.presence"))
        end
      end
    end
  end
end
