# frozen_string_literal: true

require "active_record"

module Demo1
  module Models
    class Number < ActiveRecord::Base
      include AllOverIt::Patterns::SpecificationActiveRecord::SpecificationScopeable
    end
  end
end
