module CorevistAPI
  module RFCServices::Truncations
    class RfcService < StructService
      module InstanceMethods
        def call
          @_limits.each do |param, limits|
            param = param.to_s.upcase
            next if @_struct[param]&.value.blank?

            @_struct[param].value = truncate_struct(@_struct[param].value, limits)
          end
        end

        private

        def limits_for(key, limits)
          limits[key.downcase]
        end
      end

      include InstanceMethods
    end
  end
end
