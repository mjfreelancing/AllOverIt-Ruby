# frozen_string_literal: true

require_relative '../../lib/alloverit/patterns/specification_active_record'

class WidgetValueIsSpecification
  include AllOverIt::Patterns::SpecificationActiveRecord

  def initialize(value)
    @value = value
  end

  def satisfied_by?(candidate)
    candidate.value == @value
  end

  def to_scope(relation)
    relation.where(value: @value)
  end

  def to_s
    "name = #{@value}"
  end
end
