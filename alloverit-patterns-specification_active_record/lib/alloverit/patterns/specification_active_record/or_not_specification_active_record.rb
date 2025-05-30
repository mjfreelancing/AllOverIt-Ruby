# frozen_string_literal: true

require_relative "composite_specification_active_record"

module AllOverIt
  module Patterns
    module SpecificationActiveRecord
      class OrNotSpecificationActiveRecord < CompositeSpecificationActiveRecord
        def initialize(left, right)
          @left = left
          @right = right
        end

        def satisfied_by?(candidate)
          @left.satisfied_by?(candidate) || !@right.satisfied_by?(candidate)
        end

        def to_scope(relation)
          left_ids = @left.to_scope(relation).select(:id)
          not_right_ids = relation.where.not(id: @right.to_scope(relation).select(:id)).select(:id)
          relation.where(id: left_ids).or(relation.where(id: not_right_ids))
        end

        def to_s
          "(#{@left} OR NOT #{@right})"
        end
      end
    end
  end
end
