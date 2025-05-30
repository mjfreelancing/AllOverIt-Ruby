# frozen_string_literal: true

require_relative "composite_specification_active_record"

module AllOverIt
  module Patterns
    module SpecificationActiveRecord
      class AndSpecificationActiveRecord < CompositeSpecificationActiveRecord
        def initialize(left, right)
          @left = left
          @right = right
        end

        def satisfied_by?(candidate)
          @left.satisfied_by?(candidate) && @right.satisfied_by?(candidate)
        end

        def to_scope(relation)
          @right.to_scope(@left.to_scope(relation))
        end

        def to_s
          "(#{@left} AND #{@right})"
        end
      end
    end
  end
end
