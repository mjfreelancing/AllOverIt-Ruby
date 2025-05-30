# frozen_string_literal: true

require 'active_support/concern'

module AllOverIt
  module Patterns
    module SpecificationActiveRecord
      module SpecificationScopeable
        extend ActiveSupport::Concern

        class_methods do
          # Allows: Model.scoped_to(specification)
          def scoped_to(specification)
            specification.to_scope(all)
          end
        end

        # Allows: Model.where(...).scoped_to(specification)
        def scoped_to(specification)
          specification.to_scope(self)
        end
      end
    end
  end
end
