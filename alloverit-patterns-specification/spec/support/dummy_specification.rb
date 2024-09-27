# frozen_string_literal: true

require_relative "../../lib/alloverit/patterns/specification"

class DummySpecification
  include AllOverIt::Patterns::Specification

  def satisfied_by?(_)
    true
  end
end
