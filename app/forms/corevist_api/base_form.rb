module CorevistAPI
  class BaseForm
    include ActiveModel::Validations

    def initialize(params = {})
      params.each do |name, value|
        next unless respond_to?(name)

        instance_variable_set("@#{name}", value)
      end
    end
  end
end
