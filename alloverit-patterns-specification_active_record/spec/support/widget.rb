# frozen_string_literal: true

require 'active_record'
require_relative '../../lib/alloverit/patterns/specification_active_record/specification_scopeable'

class Widget < ActiveRecord::Base
  include AllOverIt::Patterns::SpecificationActiveRecord::SpecificationScopeable
end
