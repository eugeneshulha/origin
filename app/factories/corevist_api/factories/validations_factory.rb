module CorevistAPI
  class Factories::ValidationsFactory < CorevistAPI::Factories::BaseFactory
    def initialize
      @storage = {
          required: 'ActiveModel::Validations::PresenceValidator',
          min: 'ActiveModel::Validations::LengthValidator',
          max: 'ActiveModel::Validations::LengthValidator',
          confirmation: 'ActiveModel::Validations::ConfirmationValidator',
          one_out_of: 'CorevistAPI::Validators::OneOutOfValidator'
      }
    end

    def for(attribute, validation)
      key = @storage.with_indifferent_access[validation.type]
      options = { attributes: [attribute], message: validation.message }.merge(extract_options!(validation))
      [key.constantize, options]
    end

    private

    def extract_options!(validation)
      method_name = "#{validation.type}_options"
      send(method_name, validation)
    end

    def required_options(v)
      {}
    end

    def min_options(v)
      { minimum: v.value.to_i }
    end

    def max_options(v)
      { maximum: v.value.to_i }
    end

    def confirmation_options(v)
      {}
    end
  end
end
