module CorevistAPI
  module FormatConversion
    extend ActiveSupport::Concern

    included do
      class << self

        def format_number(*fields)
          fields.each do |field|

            define_method field do
              n_format = CorevistAPI::Context.current_user.number_format
              return read_attribute(field) unless n_format

              self.read_attribute(field).to_s.amount_to_user_format(n_format)
            end
          end
        end

        def format_date(*fields)
          fields.each do |field|

            define_method field do
              d_format = CorevistAPI::Context.current_user.date_format
              return read_attribute(field) unless d_format

              self.read_attribute(field).to_s.date_to_user_format(d_format)
            end
          end
        end

        def format_time(*fields)
          fields.each do |field|

            define_method field do
              t_format = CorevistAPI::Context.current_user.time_format
              return read_attribute(field) unless t_format

              self.read_attribute(field).to_s.date_to_user_format(t_format)
            end
          end
        end

        def format_datetime(*fields)
          fields.each do |field|

            define_method field do
              t_format = CorevistAPI::Context.current_user.time_format
              d_format = CorevistAPI::Context.current_user.date_format
              return read_attribute(field) unless t_format || d_format

              self.read_attribute(field).to_s.date_to_user_format("#{d_format} #{t_format}")
            end
          end
        end
      end
    end
  end
end
