# frozen_string_literal: true

require_relative "../../lib/alloverit/patterns/specification/composite_specification"

class FalseSpecification < ::AllOverIt::Patterns::Specification::CompositeSpecification
  def satisfied_by?(_)
    false
  end
end
