# frozen_string_literal: true

module AllOverIt
  module Patterns
    module SpecificationActiveRecord
      class AlwaysTrueSpecificationActiveRecord < CompositeSpecificationActiveRecord
        def satisfied_by?(_candidate) = true
        def to_arel(_table) = Arel.sql('1=1')
        def to_s = 'true'
      end
    end
  end
end
