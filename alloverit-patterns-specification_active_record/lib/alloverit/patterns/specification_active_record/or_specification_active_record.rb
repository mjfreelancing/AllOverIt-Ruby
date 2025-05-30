# frozen_string_literal: true

require_relative "composite_specification_active_record"

module AllOverIt
  module Patterns
    module SpecificationActiveRecord
      class OrSpecificationActiveRecord < CompositeSpecificationActiveRecord
        def initialize(left, right)
          @left = left
          @right = right
        end

        def satisfied_by?(candidate)
          @left.satisfied_by?(candidate) || @right.satisfied_by?(candidate)
        end

        def to_scope(relation)
          left_ids = @left.to_scope(relation).select(:id)
          right_ids = @right.to_scope(relation).select(:id)
          relation.where(id: left_ids).or(relation.where(id: right_ids))
        end

        def to_s
          "(#{@left} OR #{@right})"
        end
      end
    end
  end
end
