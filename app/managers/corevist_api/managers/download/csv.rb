module CorevistAPI
  module Managers
    module Download
      class Csv < Base
        require 'csv'

        BLANK     = ''.freeze
        FORMAT    = '%Y%m%d%H%M%S'.freeze
        SEPARATOR = ';'.freeze
        TYPE      = 'text/csv; header=present'.freeze

        def download
          return nil if objects.blank?

          columns = objects[0].keys
          CSV.generate do |csv|
            csv << columns.map { |column| _("col|#{column}") }

            objects.each do |object|
              csv << columns.each_with_object([]) { |column, memo| memo << build_object_row(object, column) }
            end
          end
        end

        def type
          TYPE
        end

        def filename
          "#{Time.zone.now.strftime(FORMAT)}_#{params[:type]}_download.csv"
        end

        private

        def build_object_row(object, column)
          result = object.fetch(column, BLANK)
          result.respond_to?(:map) ? result.map(&:to_s).join(SEPARATOR) : result.to_s
        end
      end
    end
  end
end
