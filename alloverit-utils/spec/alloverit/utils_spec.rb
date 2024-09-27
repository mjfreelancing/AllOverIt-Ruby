# frozen_string_literal: true

require_relative "../../lib/alloverit/utils/version"

module AllOverIt
  module Utils
    RSpec.describe AllOverIt::Utils do
      it "has a version number" do
        expect(AllOverIt::Utils::VERSION).not_to be nil
      end

      describe "as_instance" do
        context "when given a class" do
          it "returns a new instance of the class" do
            expect(AllOverIt::Utils.as_instance(DummyClass)).to be_a(DummyClass)
          end
        end

        context "when given an instance" do
          it "returns the same instance" do
            instance = DummyClass.new
            expect(AllOverIt::Utils.as_instance(instance)).to eq(instance)
          end
        end
      end

      describe "ensure_instance_includes" do
        context "when the instance includes the module" do
          it "returns the instance" do
            instance = DummyClassWithModule.new
            expect(AllOverIt::Utils.ensure_instance_includes(instance, DummyClassWithModule)).to eq(instance)
          end
        end

        context "when the instance does not include the module" do
          it "raises an ArgumentError" do
            instance = DummyClass.new

            expect do
              AllOverIt::Utils.ensure_instance_includes(instance, DummyModule)
            end.to raise_error(ArgumentError, "Expected #{DummyClass.name} to include #{DummyModule.name}")
          end
        end
      end

      describe "ensure_instance_is_a" do
        context "when the instance is of the class type" do
          it "returns the instance" do
            instance = DummyClass.new
            expect(AllOverIt::Utils.ensure_instance_is_a(instance, DummyClass)).to eq(instance)
          end
        end

        context "when the instance inherits the class type" do
          it "returns the instance" do
            instance = InheritedDummyClass.new
            expect(AllOverIt::Utils.ensure_instance_is_a(instance, DummyClass)).to eq(instance)
          end
        end

        context "when the instance is not of the class type" do
          it "raises an ArgumentError" do
            instance = "test string"

            expect do
              AllOverIt::Utils.ensure_instance_is_a(instance, DummyClass)
            end.to raise_error(ArgumentError, "Expected String to inherit #{DummyClass.name}")
          end
        end
      end
    end
  end
end
