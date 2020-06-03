module CorevistAPI
  module FormatConversion
    extend ActiveSupport::Concern

    included do
      class << self

        def format_number(*fields)
          fields.each do |field|
            define_method :"#{field}_formatted" do
              send(field).to_s.amount_to_user_format(CorevistAPI::Context.current_user.number_format)
            end
          end
        end

        def format_date(*fields)
          fields.each do |field|
            define_method :"#{field}_formatted" do
              send(field).to_s.date_to_user_format(CorevistAPI::Context.current_user.date_format)
            end
          end
        end

      end

      def as_json(*)
        super.tap do |hash|
          hash.keys.each { |field| hash[field] = send("#{field}_formatted") if respond_to?("#{field}_formatted")  }
        end
      end
    end
  end
end
