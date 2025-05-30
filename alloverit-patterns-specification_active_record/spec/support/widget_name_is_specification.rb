# frozen_string_literal: true

require_relative '../../lib/alloverit/patterns/specification_active_record'

class WidgetNameIsSpecification
  include AllOverIt::Patterns::SpecificationActiveRecord

  def initialize(name)
    @name = name
  end

  def satisfied_by?(candidate)
    candidate.name == @name
  end

  def to_scope(relation)
    relation.where(name: @name)
  end

  def to_s
    "name = #{@name}"
  end
end
