# frozen_string_literal: true

require "alloverit/patterns/specification_active_record"

module Demo1
  module Specifications
    class IsEvenNumber < AllOverIt::Patterns::SpecificationActiveRecord::CompositeSpecificationActiveRecord

      def satisfied_by?(candidate)
        candidate.value % 2 == 0
      end

      def to_scope(relation)
        relation.where('value % 2 = 0')
      end

      def to_s
        'is even'
      end
    end
  end
end
