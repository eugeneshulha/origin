module CorevistAPI
  module FormatConversion
    extend ActiveSupport::Concern

    included do
      include CorevistAPI::Sortable

      class << self
        def format_number(*fields)
          sort_as_number *fields

          fields.each do |field|

            define_method field do
              begin
                _value = self.respond_to?(:read_attribute) ? read_attribute(field) : instance_variable_get("@#{field}")

                _value.to_s.to_number_with_format
              rescue ArgumentError
                return _value
              end
            end
          end
        end

        def format_amount(*fields)
          sort_as_number *fields

          fields.each do |field|

            define_method field do
              _value = self.respond_to?(:read_attribute) ? read_attribute(field) : instance_variable_get("@#{field}")
              _curr = self.respond_to?(:read_attribute) ? read_attribute(:currency) : instance_variable_get('@currency')
              _value.to_s.to_amount_with_format(_curr)
            end
          end
        end

        def format_date(*fields)
          sort_as_date *fields

          fields.each do |field|

            define_method field do
              d_format = CorevistAPI::Context.current_user.date_format
              _value = self.respond_to?(:read_attribute) ? read_attribute(field) : instance_variable_get("@#{field}")
              return _value unless d_format

              _value.to_s.to_date_with_format(d_format)
            end
          end
        end

        def format_time(*fields)
          sort_as_date *fields

          fields.each do |field|

            define_method field do
              t_format = CorevistAPI::Context.current_user.time_format
              _value = self.respond_to?(:read_attribute) ? read_attribute(field) : instance_variable_get("@#{field}")
              return _value unless t_format

              _value.to_s.to_date_with_format(t_format)
            end
          end
        end

        def format_datetime(*fields)
          sort_as_date *fields

          fields.each do |field|

            define_method field do
              t_format = CorevistAPI::Context.current_user.time_format
              d_format = CorevistAPI::Context.current_user.date_format
              _value = self.respond_to?(:read_attribute) ? read_attribute(field) : instance_variable_get("@#{field}")
              return _value unless t_format || d_format

              _value.to_s.to_date_with_format("#{d_format} #{t_format}")
            end
          end
        end
      end
    end
  end
end
