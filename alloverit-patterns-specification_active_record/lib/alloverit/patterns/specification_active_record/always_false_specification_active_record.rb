# frozen_string_literal: true

module AllOverIt
  module Patterns
    module SpecificationActiveRecord
      class AlwaysFalseSpecificationActiveRecord < CompositeSpecificationActiveRecord
        def satisfied_by?(_candidate) = false
        def to_arel(_table) = Arel.sql("1=0")
        def to_s = "false"
      end
    end
  end
end
