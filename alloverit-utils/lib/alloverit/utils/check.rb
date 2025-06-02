# frozen_string_literal: true

module AllOverIt
  module Utils
    # Provides assertion helpers for utility methods.
    module Check
      # Asserts that all provided keyword arguments are not nil. Raises ArgumentError for the first nil value.
      #
      # @param args [Hash] The keyword arguments to check for nil values.
      # @raise [ArgumentError] If any value is nil.
      def self.not_nil(**args)
        args.each do |name, value|
          raise ArgumentError, "#{name} cannot be nil" if value.nil?
        end
      end
    end
  end
end
