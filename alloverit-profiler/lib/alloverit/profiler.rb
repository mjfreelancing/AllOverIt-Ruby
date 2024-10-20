module AllOverIt
  class Profiler
    class ProfileUnit

      attr_reader :tag, :start_time, :end_time, :children, :breadcrumbs

      def initialize(tag)
        @tag = tag
        @children = []
        @breadcrumbs = []
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
      # @@root_unit ||= unit
      parent_unit = @@current_unit
      @@current_unit = unit
      result = yield
      unit.completed(parent_unit)
      @@current_unit = parent_unit
      @@root_unit.completed(nil) if root
      result
    end

    def self.breadcrumb(breadcrumb)
      @@current_unit.breadcrumbs << breadcrumb
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
        visitor.visit(unit, level) if level != -1 # ignore the root node

        unit.children.each do |child|
          accept_visitor_at_level(visitor, child, level + 1)
        end
      end
    end
  end

  class DefaultProfilerVisitor
    def initialize(logger: method(:puts))
      @logger = logger
    end

    def visit(unit, level)
      indent = "  " * level
      @logger.call("#{indent}#{unit.tag}: #{formatted_execution_time(unit)} ms")

      return unless unit.breadcrumbs && !unit.breadcrumbs.empty?

      unit.breadcrumbs.each do |message|
        @logger.call("  #{indent}=> #{message}")
      end
    end

    private

    def formatted_execution_time(unit)
      # execution_time = unit.end_time ? (unit.end_time - unit.start_time) * 1000 : 0
      execution_time = (unit.end_time - unit.start_time) * 1000
      format("%0.3f", execution_time)
    end
  end
end
