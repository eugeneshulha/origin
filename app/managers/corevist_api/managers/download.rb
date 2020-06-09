module CorevistAPI
  module Managers
    module Download
      mattr_accessor :apply_on
      @@apply_on = []

      mattr_accessor :on
      @@on = true

      def self.setup
        yield self
      end

      def self.finalize!
        clear! && return unless on

        apply_on.each { |_, _, klass| klass.include(CorevistAPI::Downloads) }
      end

      def self.clear!
        self.apply_on = @@apply_on = []
      end
    end
  end
end
