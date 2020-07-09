module CorevistAPI
  module FormatConversion
    extend ActiveSupport::Concern

    included do
      class << self

        def format_number(*fields)
          fields.each do |field|

            define_method field do
              begin
                n_format = CorevistAPI::Context.current_user.number_format
                _value = self.respond_to?(:read_attribute) ? read_attribute(field) : instance_variable_get("@#{field}")
                return send(field) unless n_format

                _value.to_s.amount_to_user_format(n_format)
              rescue ArgumentError
                return _value
              end
            end
          end
        end

        def format_date(*fields)
          fields.each do |field|

            define_method field do
              d_format = CorevistAPI::Context.current_user.date_format
              _value = self.respond_to?(:read_attribute) ? read_attribute(field) : instance_variable_get("@#{field}")
              return _value unless d_format

              _value.to_s.date_to_user_format(d_format)
            end
          end
        end

        def format_time(*fields)
          fields.each do |field|

            define_method field do
              t_format = CorevistAPI::Context.current_user.time_format
              _value = self.respond_to?(:read_attribute) ? read_attribute(field) : instance_variable_get("@#{field}")
              return _value unless t_format

              _value.to_s.date_to_user_format(t_format)
            end
          end
        end

        def format_datetime(*fields)
          fields.each do |field|

            define_method field do
              t_format = CorevistAPI::Context.current_user.time_format
              d_format = CorevistAPI::Context.current_user.date_format
              _value = self.respond_to?(:read_attribute) ? read_attribute(field) : instance_variable_get("@#{field}")
              return _value unless t_format || d_format

              _value.to_s.date_to_user_format("#{d_format} #{t_format}")
            end
          end
        end
      end
    end
  end
end
