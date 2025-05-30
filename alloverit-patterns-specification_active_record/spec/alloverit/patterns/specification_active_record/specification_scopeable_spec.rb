# frozen_string_literal: true

require 'active_record'
require 'sqlite3'
require 'active_support/concern'
require_relative '../../../../lib/alloverit/patterns/specification_active_record/specification_scopeable'
require_relative '../../../support/widget'
require_relative '../../../support/widget_name_is_specification'
require_relative '../../../support/widget_value_is_specification'

RSpec.describe AllOverIt::Patterns::SpecificationActiveRecord::SpecificationScopeable do
  before(:each) do
    Widget.delete_all
    Widget.create!(name: 'foo', value: 1)
    Widget.create!(name: 'bar', value: 2)
    Widget.create!(name: 'baz', value: 2)
    Widget.create!(name: 'foo', value: 3)
  end

  let(:name_spec) { WidgetNameIsSpecification.new('foo') }
  let(:value_spec) { WidgetValueIsSpecification.new(2) }

  describe '.scoped_to' do
    it 'returns only widgets with the specified name' do
      results = Widget.scoped_to(name_spec).pluck(:name)
      expect(results).to match_array(['foo', 'foo'])
    end

    it 'returns only widgets with the specified value' do
      results = Widget.scoped_to(value_spec).pluck(:value)
      expect(results).to match_array([2, 2])
    end
  end

  describe '#scoped_to' do
    it 'can be chained from a relation' do
      results = Widget.where(name: 'bar').scoped_to(value_spec).pluck(:name, :value)
      expect(results).to eq([['bar', 2]])
    end
  end
end
