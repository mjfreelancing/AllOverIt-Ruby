# frozen_string_literal: true

# Provides helper methods to simplify Arel node construction for common SQL operations.
module AllOverIt
  module Patterns
    module SpecificationActiveRecord
      module ArelHelpers
        # Returns an Arel node representing a modulo operation (MOD(column, value)).
        #
        # @param column [Arel::Attributes::Attribute] The column to apply modulo to.
        # @param value [Integer] The divisor.
        # @return [Arel::Nodes::NamedFunction] The Arel node for MOD(column, value).
        def self.modulo(column, value)
          Arel::Nodes::NamedFunction.new('MOD', [column, value])
        end

        # Returns an Arel node representing a case-sensitive SQL LIKE operation.
        #
        # @param column [Arel::Attributes::Attribute] The column to match against.
        # @param value [String] The value to match (should include wildcards as needed).
        # @return [Arel::Nodes::Matches] The Arel node for column LIKE value.
        def self.like(column, value)
          column.matches(value)
        end

        # Returns an Arel node representing a case-insensitive SQL LIKE operation.
        #
        # @param column [Arel::Attributes::Attribute] The column to match against.
        # @param value [String] The value to match (should include wildcards as needed).
        # @return [Arel::Nodes::Matches] The Arel node for column ILIKE value.
        def self.like_insensitive(column, value)
          column.lower.matches(value.downcase)
        end

        # Returns an Arel node representing a case-sensitive equality comparison.
        #
        # @param column [Arel::Attributes::Attribute] The column to compare.
        # @param value [String, Numeric] The value to compare.
        # @return [Arel::Nodes::Equality] The Arel node for column = value.
        def self.equals(column, value)
          column.eq(value)
        end

        # Returns an Arel node representing a case-insensitive equality comparison.
        #
        # @param column [Arel::Attributes::Attribute] The column to compare.
        # @param value [String] The value to compare (will be downcased).
        # @return [Arel::Nodes::Equality] The Arel node for column.lower.eq(value.downcase).
        def self.equals_insensitive(column, value)
          column.lower.eq(value.downcase)
        end

        # Returns an Arel node representing a less-than comparison (column < value).
        #
        # @param column [Arel::Attributes::Attribute] The column to compare.
        # @param value [Numeric] The threshold value.
        # @return [Arel::Nodes::LessThan] The Arel node for column < value.
        def self.less_than(column, value)
          column.lt(value)
        end

        # Returns an Arel node representing a less-than-or-equal comparison (column <= value).
        #
        # @param column [Arel::Attributes::Attribute] The column to compare.
        # @param value [Numeric] The value to compare.
        # @return [Arel::Nodes::LessThanOrEqual] The Arel node for column <= value.
        def self.less_than_or_equal(column, value)
          column.lteq(value)
        end

        # Returns an Arel node representing a greater-than comparison (column > value).
        #
        # @param column [Arel::Attributes::Attribute] The column to compare.
        # @param value [Numeric] The value to compare.
        # @return [Arel::Nodes::GreaterThan] The Arel node for column > value.
        def self.greater_than(column, value)
          column.gt(value)
        end

        # Returns an Arel node representing a greater-than-or-equal comparison (column >= value).
        #
        # @param column [Arel::Attributes::Attribute] The column to compare.
        # @param value [Numeric] The value to compare.
        # @return [Arel::Nodes::GreaterThanOrEqual] The Arel node for column >= value.
        def self.greater_than_or_equal(column, value)
          column.gteq(value)
        end

        # Returns an Arel node representing a not-equal comparison (column != value).
        #
        # @param column [Arel::Attributes::Attribute] The column to compare.
        # @param value [Object] The value to compare.
        # @return [Arel::Nodes::NotEqual] The Arel node for column != value.
        def self.not_equal(column, value)
          column.not_eq(value)
        end

        # Returns an Arel node representing an IN clause (column IN values).
        #
        # @param column [Arel::Attributes::Attribute] The column to check.
        # @param values [Array] The values for the IN clause.
        # @return [Arel::Nodes::In] The Arel node for column IN values.
        def self.in(column, values)
          column.in(values)
        end

        # Returns an Arel node representing a NOT IN clause (column NOT IN values).
        #
        # @param column [Arel::Attributes::Attribute] The column to check.
        # @param values [Array] The values for the NOT IN clause.
        # @return [Arel::Nodes::NotIn] The Arel node for column NOT IN values.
        def self.not_in(column, values)
          column.not_in(values)
        end

        # Returns an Arel node representing a BETWEEN clause (column BETWEEN min AND max).
        #
        # @param column [Arel::Attributes::Attribute] The column to check.
        # @param min [Object] The minimum value.
        # @param max [Object] The maximum value.
        # @return [Arel::Nodes::Between] The Arel node for column BETWEEN min AND max.
        def self.between(column, min, max)
          column.between(min..max)
        end

        # Returns an Arel node representing an IS NULL check.
        #
        # @param column [Arel::Attributes::Attribute] The column to check for NULL.
        # @return [Arel::Nodes::Equality] The Arel node for column IS NULL.
        def self.is_null(column)
          column.eq(nil)
        end

        # Returns an Arel node representing an IS NOT NULL check.
        #
        # @param column [Arel::Attributes::Attribute] The column to check for NOT NULL.
        # @return [Arel::Nodes::NotEqual] The Arel node for column IS NOT NULL.
        def self.is_not_null(column)
          column.not_eq(nil)
        end
        
        # Returns an Arel node representing a regular expression match (column ~ pattern).
        #
        # @param column [Arel::Attributes::Attribute] The column to match.
        # @param pattern [String] The regex pattern.
        # @return [Arel::Nodes::Regexp] The Arel node for column ~ pattern.
        def self.regex(column, pattern)
          Arel::Nodes::Regexp.new(column, pattern)
        end

        # Returns an Arel node representing a NOT regular expression match (column !~ pattern).
        #
        # @param column [Arel::Attributes::Attribute] The column to match.
        # @param pattern [String] The regex pattern.
        # @return [Arel::Nodes::NotRegexp] The Arel node for column !~ pattern.
        def self.not_regex(column, pattern)
          Arel::Nodes::NotRegexp.new(column, pattern)
        end

        # Returns an Arel node representing a NOT LIKE operation (case-sensitive).
        #
        # @param column [Arel::Attributes::Attribute] The column to match against.
        # @param value [String] The value to not match (should include wildcards as needed).
        # @return [Arel::Nodes::DoesNotMatch] The Arel node for column NOT LIKE value.
        def self.does_not_match(column, value)
          column.does_not_match(value)
        end

        # Returns an Arel node representing a NOT ILIKE operation (case-insensitive).
        #
        # @param column [Arel::Attributes::Attribute] The column to match against.
        # @param value [String] The value to not match (should include wildcards as needed).
        # @return [Arel::Nodes::DoesNotMatch] The Arel node for column NOT ILIKE value.
        def self.does_not_match_insensitive(column, value)
          column.lower.does_not_match(value.downcase)
        end

        # Returns an Arel node representing column = ALL(values).
        #
        # @param column [Arel::Attributes::Attribute] The column to compare.
        # @param values [Array] The values for the ALL clause.
        # @return [Arel::Nodes::Equality] The Arel node for column = ALL(values).
        def self.equals_all(column, values)
          column.eq_all(values)
        end

        # Returns an Arel node representing column != ALL(values).
        #
        # @param column [Arel::Attributes::Attribute] The column to compare.
        # @param values [Array] The values for the ALL clause.
        # @return [Arel::Nodes::NotEqual] The Arel node for column != ALL(values).
        def self.not_equals_all(column, values)
          column.not_eq_all(values)
        end

        # Returns an Arel node representing column = ANY(values).
        #
        # @param column [Arel::Attributes::Attribute] The column to compare.
        # @param values [Array] The values for the ANY clause.
        # @return [Arel::Nodes::Equality] The Arel node for column = ANY(values).
        def self.equals_any(column, values)
          column.eq_any(values)
        end

        # Returns an Arel node representing column != ANY(values).
        #
        # @param column [Arel::Attributes::Attribute] The column to compare.
        # @param values [Array] The values for the ANY clause.
        # @return [Arel::Nodes::NotEqual] The Arel node for column != ANY(values).
        def self.not_equals_any(column, values)
          column.not_eq_any(values)
        end

        # Returns an Arel node representing LIKE ALL(values).
        #
        # @param column [Arel::Attributes::Attribute] The column to match against.
        # @param values [Array] The values for the ALL clause.
        # @return [Arel::Nodes::Matches] The Arel node for column LIKE ALL(values).
        def self.like_all(column, values)
          column.matches_all(values)
        end

        # Returns an Arel node representing LIKE ANY(values).
        #
        # @param column [Arel::Attributes::Attribute] The column to match against.
        # @param values [Array] The values for the ANY clause.
        # @return [Arel::Nodes::Matches] The Arel node for column LIKE ANY(values).
        def self.like_any(column, values)
          column.matches_any(values)
        end

        # Returns an Arel node representing NOT LIKE ALL(values).
        #
        # @param column [Arel::Attributes::Attribute] The column to match against.
        # @param values [Array] The values for the ALL clause.
        # @return [Arel::Nodes::DoesNotMatch] The Arel node for column NOT LIKE ALL(values).
        def self.does_not_match_all(column, values)
          column.does_not_match_all(values)
        end

        # Returns an Arel node representing NOT LIKE ANY(values).
        #
        # @param column [Arel::Attributes::Attribute] The column to match against.
        # @param values [Array] The values for the ANY clause.
        # @return [Arel::Nodes::DoesNotMatch] The Arel node for column NOT LIKE ANY(values).
        def self.does_not_match_any(column, values)
          column.does_not_match_any(values)
        end

        # Returns an Arel node representing IN ANY(values).
        #
        # @param column [Arel::Attributes::Attribute] The column to check.
        # @param values [Array] The values for the ANY clause.
        # @return [Arel::Nodes::In] The Arel node for column IN ANY(values).
        def self.in_any(column, values)
          column.in_any(values)
        end

        # Returns an Arel node representing IN ALL(values).
        #
        # @param column [Arel::Attributes::Attribute] The column to check.
        # @param values [Array] The values for the ALL clause.
        # @return [Arel::Nodes::In] The Arel node for column IN ALL(values).
        def self.in_all(column, values)
          column.in_all(values)
        end
      end
    end
  end
end
