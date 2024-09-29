# frozen_string_literal: true

module AllOverIt
  module Utils
    module Check
      # This class method asserts that all argument values are not nil. An ArgumentError will be raised
      # for the first value that is nil.
      def self.not_nil(**args)
        args.each do |name, value|
          raise ArgumentError, "#{name} cannot be nil" if value.nil?
        end
      end
    end
  end
end
