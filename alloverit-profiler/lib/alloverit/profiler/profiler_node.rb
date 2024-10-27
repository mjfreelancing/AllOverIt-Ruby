# frozen_string_literal: true

module AllOverIt
  module Profiler

    class ProfilerNode

      attr_reader :tag, :start_time, :end_time

      def initialize(tag)
        @tag = tag
        @children = []
        @start_time = Time.now
      end

      def add_child(child)
        @children << child
      end

      def completed(parent_node)
        @end_time = Time.now
        parent_node.add_child(self) unless parent_node.nil?
      end

      # NOTE: Not exposing @children to avoid the caller mutating the array. An alternative would
      # be to return a frozen version of the array but this requires more allocations and the primary
      # intention is to only access the child elements when visiting them.
      def each_child(&block)
        @children.each(&block)
      end
    end

    private_constant :ProfilerNode
  end
end
