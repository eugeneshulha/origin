require 'active_support'
require 'active_support/core_ext'

# This class defines request-wide context and provides methods for storing
# and retrieving data from this storage.
#
# Provides thread safe storage that can be used to store some user related data.
#
# If you are using CorevistAPI::Context in Rack-based application it will be cleared after request processing
# by middleware CorevistAPI::ContextManager in order to avoid data collision. In other cases it's up to you to clear it
#
# Examples:
#
#   Context[:foo] = 'bar'
#   Context[:foo] #=> 'bar'
#   Context.clear
#   Context[:foo] #=> nil
#
module CorevistAPI
  class Context
    class << self
      # Default methods will just translate method calls into proper calls to Context::Base.
      # Default calls can be overridden to add additional behavior.

      define_method "current_user=" do |value|
        set(:current_user, value)
      end

      define_method :current_user do
        get(:current_user)
      end

      delegate :[], :[]=, to: :data, allow_nil: true

      # Clears context data.
      def clear
        Thread.current[:context] = nil
      end

      private

      # Shorthand methods to make data definition more beautiful.
      def set(key, value)
        data[key] = value
      end

      def get(key)
        data[key]
      end

      def data
        Thread.current[:context] ||= {}
      end
    end
  end
end
