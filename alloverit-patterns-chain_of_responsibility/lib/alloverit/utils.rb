# frozen_string_literal: true

# TODO: to be moved to a Utils gem
module AllOverIt
  module Utils
    def self.ensure_instance(other)
      other.is_a?(Class) ? other.new : other
    end
  end
end
