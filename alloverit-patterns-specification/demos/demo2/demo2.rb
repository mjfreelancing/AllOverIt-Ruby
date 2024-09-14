#!/usr/bin/env ruby
# frozen_string_literal: true
# rubocop:disable all

require "bundler/setup"
require_relative "models/chilli"
require_relative "models/scoville_range"
require_relative "specifications/has_color"
require_relative "specifications/has_origin"
require_relative "specifications/is_mild"

module Demo2
  Chilli = Demo2::Models::Chilli
  ScovilleRange = Demo2::Models::ScovilleRange
  HasColorSpec = Demo2::Specifications::HasColor
  HasOriginSpec = Demo2::Specifications::HasOrigin
  IsMildSpec = Demo2::Specifications::IsMild

  chilli_varieties = Chilli.known_varieties

  not_green_spec = HasColorSpec.new("green").not
  mexico_or_india_spec = HasOriginSpec.new("mexico").or(HasOriginSpec.new("india"))
  combined_spec = IsMildSpec.or(not_green_spec.and(mexico_or_india_spec))

  filtered_chillis = chilli_varieties.select { |chilli| combined_spec.satisfied_by?(chilli) }

  filtered_chillis.each do |chilli|
    puts "Name: #{chilli.name}, Origin: #{chilli.origin}, Colors: #{chilli.colors.join(', ')}, Scoville Range: #{chilli.scoville_range}"
  end
end
