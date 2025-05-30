# frozen_string_literal: true

require_relative "composite_specification_active_record"

module AllOverIt
  module Patterns
    module SpecificationActiveRecord
      class NotSpecificationActiveRecord < CompositeSpecificationActiveRecord
        def initialize(specification)
          @specification = specification
        end

        def satisfied_by?(candidate)
          !@specification.satisfied_by?(candidate)
        end

        def to_scope(relation)
          relation.where.not(id: @specification.to_scope(relation).select(:id))
        end

        def to_s
          "(NOT #{@specification})"
        end
      end
    end
  end
end
