module Demo2
  module Models
    class ScovilleRange
      attr_accessor :lower, :upper

      def initialize(lower, upper)
        @lower, @upper = validate_range(lower, upper)
      end

      def to_s
        "#{lower} - #{upper}"
      end

      private

      def validate_range(lower, upper)
        if lower <= 0 || upper <= 0
          raise ArgumentError, "Both values must be greater than 0"
        elsif lower > upper
          raise ArgumentError, "Lower value must be less than or equal to upper value"
        end

        [lower, upper]
      end
    end
  end
end