module CorevistAPI
  module UserTrackable
    extend ActiveSupport::Concern

    included do
      before_create :set_creator
      before_update :set_updator

      def created_by
        return self.read_attribute(:created_by) if self.read_attribute(:created_by).to_i < 1

        CorevistAPI::User.find_by(id: self.read_attribute(:created_by))&.username
      end

      def updated_by
        return self.read_attribute(:updated_by) if self.read_attribute(:updated_by).to_i < 1

        CorevistAPI::User.find_by(id: self.read_attribute(:updated_by))&.username
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
