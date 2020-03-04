module CorevistAPI
  module FormValidations
    ARRAY_KEY = 'array'.freeze

    def self.included(base)
      base.extend(ClassMethods)
      base.include(InstanceMethods)
    end

    module ClassMethods
      include CorevistAPI::Factories::FactoryInterface

      def validate_component(component_id, on_page:, on_step: nil)
        result = service_for(:page_configs_read, on_page).call
        raise StandardError, 'page configs not found' unless result.data

        page = result.data.to_configuration

        component = if on_step
                      page.multiform_search_for(on_step, component_id)
                    else
                      page.components&.find_one_by(uuid: component_id.to_s)
                    end

        raise StandardError, 'component configs not found' unless component

        # convert basic structure to objects with getters and setters
        elements = component.elements.flatten

        elements.each { |element| element.transform(self) }
      end
    end

    module InstanceMethods

      def validate_component(component_id, on_page:)
        self.class.validate_component(component_id, on_page: on_page)
      end
    end
  end
end
