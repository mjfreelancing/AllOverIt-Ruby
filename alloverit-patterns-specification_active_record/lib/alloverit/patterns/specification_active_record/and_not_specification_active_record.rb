# frozen_string_literal: true

require_relative "composite_specification_active_record"

module AllOverIt
  module Patterns
    module SpecificationActiveRecord
      class AndNotSpecificationActiveRecord < CompositeSpecificationActiveRecord
        def initialize(left, right)
          super()
          
          @left = left
          @right = right
        end

        def satisfied_by?(candidate)
          @left.satisfied_by?(candidate) && !@right.satisfied_by?(candidate)
        end

        def to_scope(relation)
          left_scope = @left.to_scope(relation)
          right_scope = @right.to_scope(relation)
          left_scope.where.not(id: right_scope.select(:id))
        end

        def to_s
          "(#{@left} AND NOT #{@right})"
        end
      end
    end
  end
end
