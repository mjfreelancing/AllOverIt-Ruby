module AllOverIt
  class Profiler
    ProfileBreadcrumb = Struct.new(:message)

    class ProfileNode

      attr_reader :tag, :start_time, :end_time, :children

      def initialize(tag)
        @tag = tag
        @children = []
        @start_time = Time.now
      end

      def completed(parent_node)
        @end_time = Time.now
        parent_node.children << self unless parent_node.nil?
      end

      # def children
      #   @children.map(&:freeze).freeze
      # end
    end

    private_constant :ProfileNode

    def self.call(tag, root: false)
      @is_root = root

      if @is_root
        @@root_node = ProfileNode.new("root")
        @@current_node = @@root_node
      end

      raise StandardError, "The first profiler call must indicate it is the root" if @@root_node.nil?

      unit = ProfileNode.new(tag)
      parent_unit = @@current_node
      @@current_node = unit
      result = yield
      unit.completed(parent_unit)
      @@current_node = parent_unit
      @@root_node.completed(nil) if root
      result
    end

    def self.breadcrumb(breadcrumb)
      @@current_node.children << ProfileBreadcrumb.new(breadcrumb)
    end

    def self.root
      @@root_node
    end

    def self.accept_visitor(visitor, node: root)
      accept_visitor_at_level(visitor, node, -1)
    end

    class << self
      private

      def accept_visitor_at_level(visitor, node, level)
        visit_node(visitor, node, level) if node.is_a?(ProfileNode)
        visit_breadcrumb(visitor, node, level) if node.is_a?(ProfileBreadcrumb)
      end

      def visit_node(visitor, node, level)
        visitor.visit_node(node, level) if level != -1 # ignore the root node

        node.children.each do |child|
          accept_visitor_at_level(visitor, child, level + 1)
        end
      end

      def visit_breadcrumb(visitor, unit, level)
        visitor.visit_breadcrumb(unit, level)
      end
    end
  end

  class DefaultProfileVisitor
    def initialize(logger: method(:puts))
      @logger = logger
    end

    def visit_node(node, level)
      indent = "  " * level
      @logger.call("#{indent}#{node.tag}: #{formatted_execution_time(node)} ms")
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
