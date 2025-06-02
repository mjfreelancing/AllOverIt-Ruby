# frozen_string_literal: true

require_relative "profiler_node"

module AllOverIt
  module Profiler
    # Represents a breadcrumb in the profiling tree, containing a timestamp and message.
    ProfilerBreadcrumb = Struct.new(:timestamp, :message)

    # The root node for a profiling session, managing the profiling tree and breadcrumbs.
    class ProfilerRoot
      # Initializes a new ProfilerRoot with a root node.
      def initialize
        @root_node = ProfilerNode.new("root")
        @current_node = @root_node
      end

      # Profiles a block of code under a specific tag.
      #
      # @param tag [String] The tag for the profiling node.
      # @yield The block to profile.
      # @return [Object] The result of the block.
      def call(tag, &block)
        is_root = @current_node == @root_node
        node = ProfilerNode.new(tag)
        parent_node = @current_node
        @current_node = node
        result = block.call
        node.completed(parent_node)
        @current_node = parent_node
        @root_node.completed(nil) if is_root
        result
      end

      # Adds a breadcrumb message to the current profiling node.
      #
      # @param message [String] The breadcrumb message.
      def breadcrumb(message)
        node = ProfilerBreadcrumb.new(Time.now, message)
        @current_node.add_child(node)
      end

      # Accepts a visitor for traversing the profiling tree.
      #
      # @param visitor [Object] The visitor object.
      # @param node [Object, nil] The node to start from (optional).
      def accept_visitor(visitor, node)
        accept_visitor_at_level(visitor, node || @root_node, -1)
      end

      private

      # Recursively accepts a visitor at the given level in the profiling tree.
      def accept_visitor_at_level(visitor, node, level)
        visit_node(visitor, node, level) if node.is_a?(ProfilerNode)
        visit_breadcrumb(visitor, node, level) if node.is_a?(ProfilerBreadcrumb)
      end

      # Visits a profiling node with the visitor.
      def visit_node(visitor, node, level)
        visitor.visit_node(node, level) if level != -1 # ignore the root node

        node.each_child do |child|
          accept_visitor_at_level(visitor, child, level + 1)
        end
      end

      # Visits a breadcrumb with the visitor.
      def visit_breadcrumb(visitor, unit, level)
        visitor.visit_breadcrumb(unit, level)
      end
    end

    private_constant :ProfilerRoot
  end
end
