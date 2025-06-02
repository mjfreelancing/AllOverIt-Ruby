# frozen_string_literal: true

require "active_support/concern"

module AllOverIt
  module Patterns
    module SpecificationActiveRecord
      # Provides methods to apply a specification as a scope to ActiveRecord models and relations.
      module SpecificationScopeable
        extend ActiveSupport::Concern

        class_methods do
          # Applies a specification to the entire model as a scope.
          #
          # @param specification [SpecificationActiveRecord] The specification to apply.
          # @return [ActiveRecord::Relation] The relation with the specification applied as a WHERE clause.
          #
          # @example
          #   Model.scoped_to(specification)
          def scoped_to(specification)
            specification.to_scope(all)
          end
        end

        # Applies a specification to the current relation as a scope.
        #
        # @param specification [SpecificationActiveRecord] The specification to apply.
        # @return [ActiveRecord::Relation] The relation with the specification applied as a WHERE clause.
        #
        # @example
        #   Model.where(...).scoped_to(specification)
        def scoped_to(specification)
          specification.to_scope(self)
        end
      end
    end
  end
end
