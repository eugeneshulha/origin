module CorevistAPI
  module FormatConversion
    extend ActiveSupport::Concern

    included do
      class << self

        def format_number(*fields)
          fields.each do |field|

            define_method field do
              n_format = CorevistAPI::Context.current_user.number_format
              value = self.respond_to?(:read_attribute) ? read_attribute(field) : instance_variable_get("@#{field}")
              return send(field) unless n_format

              value.to_s.amount_to_user_format(n_format)
            end

            define_method "#{field}="do |value|
              n_format = CorevistAPI::Context.current_user.number_format
              value = value.to_s.amount_to_user_format(n_format)
              self.respond_to?(:write_attribute) ? write_attribute(field, value) : instance_variable_set("@#{field}", value)

              value
            end
          end
        end

        def format_date(*fields)
          fields.each do |field|

            define_method field do
              d_format = CorevistAPI::Context.current_user.date_format
              value = self.respond_to?(:read_attribute) ? read_attribute(field) : instance_variable_get("@#{field}")
              return value unless d_format

              value.to_s.date_to_user_format(d_format)
            end

            define_method "#{field}="do |value|
              d_format = CorevistAPI::Context.current_user.date_format
              value = value.to_s.date_to_user_format(d_format)
              self.respond_to?(:write_attribute) ? write_attribute(field, value) : instance_variable_set("@#{field}", value)

              value
            end
          end
        end

        def format_time(*fields)
          fields.each do |field|

            define_method field do
              t_format = CorevistAPI::Context.current_user.time_format
              value = self.respond_to?(:read_attribute) ? read_attribute(field) : instance_variable_get("@#{field}")
              return value unless t_format

              value.to_s.date_to_user_format(t_format)
            end

            define_method "#{field}="do |value|
              t_format = CorevistAPI::Context.current_user.time_format
              value = value.to_s.date_to_user_format(t_format)
              self.respond_to?(:write_attribute) ? write_attribute(field, value) : instance_variable_set("@#{field}", value)

              value
            end
          end
        end

        def format_datetime(*fields)
          fields.each do |field|

            define_method field do
              t_format = CorevistAPI::Context.current_user.time_format
              d_format = CorevistAPI::Context.current_user.date_format
              value = self.respond_to?(:read_attribute) ? read_attribute(field) : instance_variable_get("@#{field}")
              return value unless t_format || d_format

              value.to_s.date_to_user_format("#{d_format} #{t_format}")
            end

            define_method "#{field}="do |value|
              t_format = CorevistAPI::Context.current_user.time_format
              d_format = CorevistAPI::Context.current_user.date_format

              value = value.to_s.date_to_user_format("#{d_format} #{t_format}")
              self.respond_to?(:write_attribute) ? write_attribute(field, value) : instance_variable_set("@#{field}", value)

              value
            end
          end
        end
      end
    end
  end
end
