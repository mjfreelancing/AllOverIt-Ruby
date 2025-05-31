# frozen_string_literal: true

require "spec_helper"
require "alloverit/patterns/specification_active_record/arel_helpers"
require_relative "../../../support/widget"

module AllOverIt
  module Patterns
    module SpecificationActiveRecord
      RSpec.describe ArelHelpers do
        let(:arel_table) { Widget.arel_table }

        describe ".modulo" do
          it "returns a MOD Arel node" do
            node = described_class.modulo(arel_table[:value], 2)
            expect(node.to_sql).to eq('MOD("widgets"."value", 2)')
          end
        end

        describe ".like" do
          it "returns a LIKE node" do
            expect(described_class.like(arel_table[:name], "%foo%").to_sql).to eq("\"widgets\".\"name\" LIKE '%foo%'")
          end
        end

        describe ".like_insensitive" do
          it "returns a case-insensitive LIKE node" do
            expect(described_class.like_insensitive(arel_table[:name], "%FOO%").to_sql).to eq("LOWER(\"widgets\".\"name\") LIKE '%foo%'")
          end
        end

        describe ".not_like" do
          it "returns a NOT LIKE node" do
            expect(described_class.not_like(arel_table[:name], "%foo%").to_sql).to eq("\"widgets\".\"name\" NOT LIKE '%foo%'")
          end
        end

        describe ".not_like_insensitive" do
          it "returns a case-insensitive NOT LIKE node" do
            expect(described_class.not_like_insensitive(arel_table[:name], "%FOO%").to_sql).to eq("LOWER(\"widgets\".\"name\") NOT LIKE '%foo%'")
          end
        end

        describe ".equals" do
          it "returns an equality node for a number" do
            expect(described_class.equals(arel_table[:value], 1).to_sql).to eq('"widgets"."value" = 1')
          end

          it "returns an equality node for a string" do
            expect(described_class.equals(arel_table[:name], "foo").to_sql).to eq("\"widgets\".\"name\" = 'foo'")
          end
        end

        describe ".equals_insensitive" do
          it "returns a case-insensitive equality node" do
            expect(described_class.equals_insensitive(arel_table[:name], "FOO").to_sql).to eq("LOWER(\"widgets\".\"name\") = 'foo'")
          end
        end

        describe ".not_equal" do
          it "returns a not-equality node" do
            expect(described_class.not_equal(arel_table[:value], 1).to_sql).to eq('"widgets"."value" != 1')
          end
        end

        describe ".not_equal_insensitive" do
          it "returns a case-insensitive not-equality node" do
            expect(described_class.not_equal_insensitive(arel_table[:name], "FOO").to_sql).to eq("LOWER(\"widgets\".\"name\") != 'foo'")
          end
        end

        describe ".less_than" do
          it "returns a less-than node" do
            expect(described_class.less_than(arel_table[:value], 2).to_sql).to eq('"widgets"."value" < 2')
          end
        end

        describe ".less_than_or_equal" do
          it "returns a less-than-or-equal node" do
            expect(described_class.less_than_or_equal(arel_table[:value], 2).to_sql).to eq('"widgets"."value" <= 2')
          end
        end

        describe ".greater_than" do
          it "returns a greater-than node" do
            expect(described_class.greater_than(arel_table[:value], 2).to_sql).to eq('"widgets"."value" > 2')
          end
        end

        describe ".greater_than_or_equal" do
          it "returns a greater-than-or-equal node" do
            expect(described_class.greater_than_or_equal(arel_table[:value], 2).to_sql).to eq('"widgets"."value" >= 2')
          end
        end

        describe ".in" do
          it "returns an IN node" do
            expect(described_class.in(arel_table[:value], [1,2]).to_sql).to eq('"widgets"."value" IN (1, 2)')
          end
        end

        describe ".not_in" do
          it "returns a NOT IN node" do
            expect(described_class.not_in(arel_table[:value], [1,2]).to_sql).to eq('"widgets"."value" NOT IN (1, 2)')
          end
        end

        describe ".between" do
          it "returns a BETWEEN node" do
            expect(described_class.between(arel_table[:value], 1, 3).to_sql).to eq('"widgets"."value" BETWEEN 1 AND 3')
          end
        end

        describe ".is_null" do
          it "returns an IS NULL node" do
            expect(described_class.is_null(arel_table[:value]).to_sql).to eq('"widgets"."value" IS NULL')
          end
        end

        describe ".is_not_null" do
          it "returns an IS NOT NULL node" do
            expect(described_class.is_not_null(arel_table[:value]).to_sql).to eq('"widgets"."value" IS NOT NULL')
          end
        end

        describe ".regex" do
          it "returns a regex node (if supported by DB)" do
            sql = described_class.regex(arel_table[:name], "foo").to_sql
            # Regex SQL varies by DB, so just check for the presence of the pattern
            expect(sql).to match(/~|REGEXP/)
          rescue NotImplementedError
            skip("Regex not supported by this DB adapter")
          end
        end

        describe ".not_regex" do
          it "returns a NOT regex node (if supported by DB)" do
            sql = described_class.not_regex(arel_table[:name], "foo").to_sql
            expect(sql).to match(/!~|NOT REGEXP/)
          rescue NotImplementedError
            skip("NotRegex not supported by this DB adapter")
          end
        end
      end
    end
  end
end
