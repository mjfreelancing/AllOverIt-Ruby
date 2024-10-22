module AllOverIt
  class Profiler
    ProfileBreadcrumb = Struct.new(:message)

    class ProfileUnit

      attr_reader :tag, :start_time, :end_time, :children

      def initialize(tag)
        @tag = tag
        @children = []
        @start_time = Time.now
      end

      def completed(parent_unit)
        @end_time = Time.now
        parent_unit.children << self unless parent_unit.nil?
      end

      # def children
      #   @children.map(&:freeze).freeze
      # end
    end

    private_constant :ProfileUnit

    def self.call(tag, root: false)
      @is_root = root

      if @is_root
        @@root_unit = ProfileUnit.new("root")
        @@current_unit = @@root_unit
      end

      raise StandardError, "The first profiler call must indicate it is the root" if @@root_unit.nil?

      unit = ProfileUnit.new(tag)
      parent_unit = @@current_unit
      @@current_unit = unit
      result = yield
      unit.completed(parent_unit)
      @@current_unit = parent_unit
      @@root_unit.completed(nil) if root
      result
    end

    def self.breadcrumb(breadcrumb)
      @@current_unit.children << ProfileBreadcrumb.new(breadcrumb)
    end

    def self.root
      @@root_unit
    end

    def self.accept_visitor(visitor, unit: root)
      accept_visitor_at_level(visitor, unit, -1)
    end

    class << self
      private

      def accept_visitor_at_level(visitor, unit, level)
        visit_unit(visitor, unit, level) if unit.is_a?(ProfileUnit)
        visit_breadcrumb(visitor, unit, level) if unit.is_a?(ProfileBreadcrumb)
      end

      def visit_unit(visitor, unit, level)
        visitor.visit_unit(unit, level) if level != -1 # ignore the root node

        unit.children.each do |child|
          accept_visitor_at_level(visitor, child, level + 1)
        end
      end

      def visit_breadcrumb(visitor, unit, level)
        visitor.visit_breadcrumb(unit, level)
      end
    end
  end

  class DefaultProfilerVisitor
    def initialize(logger: method(:puts))
      @logger = logger
    end

    def visit_unit(unit, level)
      indent = "  " * level
      @logger.call("#{indent}#{unit.tag}: #{formatted_execution_time(unit)} ms")
    end

    def visit_breadcrumb(breadcrumb, level)
      indent = "  " * level
      @logger.call("#{indent}=> #{breadcrumb.message}")
    end

    private

    def formatted_execution_time(unit)
      execution_time = (unit.end_time - unit.start_time) * 1000
      format("%0.3f", execution_time)
    end
  end
end
