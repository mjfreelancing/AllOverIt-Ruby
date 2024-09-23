# frozen_string_literal: true

module AllOverIt
  module Utils
    def self.ensure_instance(other)
      other.is_a?(Class) ? other.new : other
    end
  end
end
