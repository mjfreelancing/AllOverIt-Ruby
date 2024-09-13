module Demo2
  module Models
    class Chilli
      attr_accessor :name, :colors, :origin, :scoville_range

      def initialize(name, colors, origin, scoville_range)
        @name = name
        @colors = validate_colors(colors)
        @origin = origin
        @scoville_range = validate_scoville_range(scoville_range)
      end

      def self.known_varieties
        [
          Chilli.new(
            "Habanero",
            %w[Orange Red White Brown],
            "Mexico",
            ScovilleRange.new(100_000, 350_000)
          ),

          Chilli.new(
            "Bird’s Eye",
            %w[Red Green],
            "Thailand",
            ScovilleRange.new(50_000, 100_000)
          ),

          Chilli.new(
            "Ghost Pepper",
            %w[Red Orange Chocolate Yellow],
            "India",
            ScovilleRange.new(1_000_000, 1_200_000)
          ),

          Chilli.new(
            "Jalapeño",
            %w[Green Red],
            "Mexico",
            ScovilleRange.new(2_500, 8_000)
          ),

          Chilli.new(
            "African Bird’s Eye",
            %w[Red],
            "Africa",
            ScovilleRange.new(50_000, 175_000)
          ),

          Chilli.new(
            "7 Pot",
            %w[Yellow Red],
            "Caribbean",
            ScovilleRange.new(1_200_000, 1_463_700)
          )
        ]
      end

      private

      def validate_colors(colors)
        raise ArgumentError, "Colors must be a non-empty array" unless colors.is_a?(Array) && !colors.empty?

        colors
      end

      def validate_scoville_range(scoville_range)
        raise ArgumentError, "scoville_range must be an instance of #{ScovilleRange.name}" unless scoville_range.is_a?(ScovilleRange)

        scoville_range
      end
    end
  end
end
