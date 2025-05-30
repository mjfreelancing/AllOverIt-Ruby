require 'active_record'
require 'sqlite3'
require_relative "../specifications/has_color"
require_relative "../specifications/has_origin"
require_relative "../specifications/is_mild"
require_relative "../../../lib/alloverit/patterns/specification_active_record/specification_scopeable"

module Demo2
  module Models
    class Chilli < ActiveRecord::Base
      include AllOverIt::Patterns::SpecificationActiveRecord::SpecificationScopeable
      def color_list
        colors.split(',')
      end
      def scoville_range
        "#{scoville_lower} - #{scoville_upper}"
      end
    end
  end
end
