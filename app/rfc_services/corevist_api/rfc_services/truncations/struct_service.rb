module CorevistAPI
  module RFCServices::Truncations
    class StructService < CorevistAPI::Services::BaseService
      module InstanceMethods
        def initialize(struct, limits)
          @_struct = struct
          @_limits = limits
        end

        def call
          raise NotImplementedError
        end

        private

        def truncate_struct(struct, limits)
          send("truncate_#{struct.class.name.underscore}", struct, limits)
        rescue StandardError
          struct
        end

        def truncate_array(array, limits)
          array.map do |struct|
            truncate_struct(struct, limits)
          end
        end

        def truncate_hash(hash, limits)
          hash.map do |key, value|
            [key, truncate_struct(value, limits_for(key, limits))]
          end.to_h
        end

        def truncate_string(string, limit)
          string.mb_chars.limit(limit).to_s
        end

        def limits_for(key, limits)
          limits[key]
        end
      end

      include InstanceMethods
    end
  end
end
