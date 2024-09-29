# frozen_string_literal: true

require_relative "../../lib/alloverit/utils/version"

module AllOverIt
  module Utils
    RSpec.describe Utils do
      let(:dummy_class) { DummyClass.new }
      let(:dummy_class_with_module) { DummyClassWithModule.new }
      let(:inherited_dummy_class) { InheritedDummyClass.new }

      describe ".as_instance" do
        it "raises ArgumentError when nil" do
          expect do
            described_class.as_instance(nil)
          end.to raise_error(ArgumentError, "instance_or_class cannot be nil")
        end

        context "when given a class" do
          it "returns a new instance of the class" do
            expect(described_class.as_instance(DummyClass)).to be_instance_of(DummyClass)
          end
        end

        context "when given an instance" do
          it "returns the same instance" do
            expect(described_class.as_instance(dummy_class)).to eq(dummy_class)
          end
        end
      end

      describe ".ensure_instance_includes" do
        it "raises ArgumentError when instance nil" do
          expect do
            described_class.ensure_instance_includes(nil, DummyClassWithModule)
          end.to raise_error(ArgumentError, "instance cannot be nil")
        end

        it "raises ArgumentError when module is nil" do
          expect do
            described_class.ensure_instance_includes(dummy_class_with_module, nil)
          end.to raise_error(ArgumentError, "module_type cannot be nil")
        end

        context "when the instance includes the module" do
          it "returns the instance" do
            expect(described_class.ensure_instance_includes(dummy_class_with_module, DummyClassWithModule)).to eq(dummy_class_with_module)
          end
        end

        context "when the instance does not include the module" do
          it "raises an ArgumentError" do
            expect do
              described_class.ensure_instance_includes(dummy_class, DummyModule)
            end.to raise_error(ArgumentError, "Expected #{DummyClass.name} to include #{DummyModule.name}")
          end
        end
      end

      describe ".ensure_instance_is_a" do
        it "raises ArgumentError when instance is nil" do
          expect do
            described_class.ensure_instance_is_a(nil, DummyClass)
          end.to raise_error(ArgumentError, "instance cannot be nil")
        end

        it "raises ArgumentError when class nil" do
          expect do
            described_class.ensure_instance_is_a(dummy_class, nil)
          end.to raise_error(ArgumentError, "class_type cannot be nil")
        end

        context "when the instance is of the class type" do
          it "returns the instance" do
            expect(described_class.ensure_instance_is_a(dummy_class, DummyClass)).to eq(dummy_class)
          end
        end

        context "when the instance inherits the class type" do
          it "returns the instance" do
            expect(described_class.ensure_instance_is_a(inherited_dummy_class, DummyClass)).to eq(inherited_dummy_class)
          end
        end

        context "when the instance is not of the class type" do
          it "raises an ArgumentError" do
            expect do
              described_class.ensure_instance_is_a("test string", DummyClass)
            end.to raise_error(ArgumentError, "Expected String to inherit #{DummyClass.name}")
          end
        end
      end
    end
  end
end
