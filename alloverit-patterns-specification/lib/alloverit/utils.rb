# frozen_string_literal: true

module Alloverit
  module Utils
    def self.instantiate_if_class(other)
      other.is_a?(Class) ? other.new : other
    end
  end
end
