module CorevistAPI
  module Downloads
    extend ActiveSupport::Concern

    included do |base|
      form_performer_for :download
      base.prepend(Download)
    end

    module Download
      ERROR_WRONG_FORMAT = 'error|downloads.wrong_format'.freeze

      def download
        raise CorevistAPI::ServiceException.new(_(ERROR_WRONG_FORMAT)) if wrong_format?

        super
      end

      private

      def performer_name
        return super unless action_name.to_sym == :download

        "#{action_prefix}_index".to_sym
      end

      def success(info_or_infos, data = nil)
        return super unless action_name.to_sym == :download

        objects = data[controller_name.to_sym] || data[:items]
        manager = download_manager_for(format, objects, type: controller_name)
        send_data(manager.download, type: manager.type, filename: manager.filename)
      end

      def wrong_format?
        Settings.dig(:downloads, :formats).to_a.exclude?(format)
      end

      def format
        params[:format].to_s.downcase.to_sym
      end
    end
  end
end
