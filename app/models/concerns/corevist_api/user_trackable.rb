module CorevistAPI
  module UserTrackable
    extend ActiveSupport::Concern

    included do
      before_create :set_creator
      before_update :set_updator

      def created_by
        CorevistAPI::User.find_by(id: self.read_attribute(:created_by))&.username || self.read_attribute(:created_by)
      end

      def updated_by
        CorevistAPI::User.find_by(id: self.read_attribute(:updated_by))&.username || self.read_attribute(:updated_by)
      end

      private

      def set_creator
        self.created_by = CorevistAPI::Context.current_user&.id || 'system'
        self.updated_by = CorevistAPI::Context.current_user&.id || 'system'
      end

      def set_updator
        self.updated_by = CorevistAPI::Context.current_user&.id || 'system'
      end
    end
  end
end
