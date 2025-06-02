# frozen_string_literal: true

module AllOverIt
  module Profiler
    # Default visitor for traversing the profiling tree, logging nodes and breadcrumbs.
    class DefaultVisitor
      # Initializes a new DefaultVisitor with an optional logger.
      #
      # @param logger [Proc] The logger to use (default: method(:puts)).
      def initialize(logger: method(:puts))
        @logger = logger
      end

      # Visits a profiling node and logs its tag and execution time.
      #
      # @param node [ProfilerNode] The profiling node.
      # @param level [Integer] The depth level in the tree.
      def visit_node(node, level)
        indent = "  " * level
        @logger.call("#{indent}#{node.tag}: #{formatted_execution_time(node)}ms")
      end

      # Visits a breadcrumb and logs its message.
      #
      # @param breadcrumb [ProfilerBreadcrumb] The breadcrumb.
      # @param level [Integer] The depth level in the tree.
      def visit_breadcrumb(breadcrumb, level)
        indent = "  " * level
        @logger.call("#{indent}=> #{breadcrumb.message}")
      end

      private

      # Formats the execution time of a profiling node in milliseconds.
      #
      # @param node [ProfilerNode] The profiling node.
      # @return [String] The formatted execution time in milliseconds.
      def formatted_execution_time(node)
        execution_time = (node.end_time - node.start_time) * 1000
        format("%0.3f", execution_time)
      end
    end
  end
end
