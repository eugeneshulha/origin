module CorevistAPI
  module UserTrackable
    extend ActiveSupport::Concern

    included do
      def created_by
        CorevistAPI::User.find_by(id: self.read_attribute(:created_by))&.username || self.read_attribute(:created_by)
      end

      def updated_by
        CorevistAPI::User.find_by(id: self.read_attribute(:updated_by))&.username || self.read_attribute(:updated_by)
      end
    end
  end
end
