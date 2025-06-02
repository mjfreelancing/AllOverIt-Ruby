# frozen_string_literal: true

module AllOverIt
  module Profiler
    # Represents a node in the profiling tree, tracking execution time and child nodes.
    class ProfilerNode
      # @return [String] The tag for this node.
      attr_reader :tag

      # @return [Time] The start time of this node.
      attr_reader :start_time

      # @return [Time, nil] The end time of this node.
      attr_reader :end_time

      # Initializes a new ProfilerNode with the given tag.
      #
      # @param tag [String] The tag for this node.
      def initialize(tag)
        @tag = tag
        @children = []
        @start_time = Time.now
      end

      # Adds a child node or breadcrumb to this node.
      #
      # @param child [ProfilerNode, ProfilerBreadcrumb] The child to add.
      def add_child(child)
        @children << child
      end

      # Marks this node as completed and adds it to the parent node's children.
      #
      # @param parent_node [ProfilerNode, nil] The parent node.
      def completed(parent_node)
        @end_time = Time.now
        parent_node.add_child(self) unless parent_node.nil?
      end

      # Iterates over each child node or breadcrumb.
      #
      # @yield [child] Gives each child to the block.
      def each_child(&block)
        # NOTE: Not exposing @children to avoid the caller mutating the array. An alternative would
        #       be to return a frozen version of the array but this requires more allocations and the
        #       primary intention is to only access the child elements when visiting them.
        @children.each(&block)
      end
    end

    private_constant :ProfilerNode
  end
end
