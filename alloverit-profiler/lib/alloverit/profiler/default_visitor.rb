# frozen_string_literal: true

module AllOverIt
  module Profiler
    class DefaultVisitor
      def initialize(logger: method(:puts))
        @logger = logger
      end

      def visit_node(node, level)
        indent = "  " * level
        @logger.call("#{indent}#{node.tag}: #{formatted_execution_time(node)}ms")
      end

      def visit_breadcrumb(breadcrumb, level)
        indent = "  " * level
        @logger.call("#{indent}=> #{breadcrumb.message}")
      end

      private

      def formatted_execution_time(node)
        execution_time = (node.end_time - node.start_time) * 1000
        format("%0.3f", execution_time)
      end
    end
  end
end
