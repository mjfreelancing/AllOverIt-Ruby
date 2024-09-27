# frozen_string_literal: true

require_relative "../../lib/alloverit/patterns/specification/composite_specification"

class TrueSpecification < ::AllOverIt::Patterns::Specification::CompositeSpecification
  def satisfied_by?(_)
    true
  end
end
