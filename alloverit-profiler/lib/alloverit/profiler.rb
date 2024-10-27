# frozen_string_literal: true

require_relative "profiler/profiler_root"

module AllOverIt
  module Profiler
    @cache = {}

    # Use of this method is optional. if used, it relies on :key_lookup of :cleanup is true
    def self.start(options = {}, &block)
      raise ArgumentError, "A block must be provided to track" unless block_given?

      options[:cleanup] ||= false
      options[:key_lookup] ||= -> { "default" }

      @options = options

      block.call

      cleanup if options[:cleanup]
    end

    # In the methods below, allowing the caller to provide a lookup key provides flexibility

    def self.cleanup(lookup_key: nil)
      key = lookup_key || @options[:key_lookup].call
      @cache.delete(key)
    end

    def self.track(tag, lookup_key: nil, &block)
      raise ArgumentError, "A block must be provided to track" unless block_given?

      key = lookup_key || @options[:key_lookup].call

      @cache[key] ||= ProfilerRoot.new

      @cache[key].call(tag) do
        block.call
      end
    end

    def self.breadcrumb(lookup_key = nil, message)
      key = lookup_key || @options[:key_lookup].call

      raise KeyError, "No profiler found for key: #{key}" unless @cache.key?(key)

      @cache[key].breadcrumb(message)
    end

    def self.accept_visitor(lookup_key = nil, visitor, node: nil)
      key = lookup_key || @options[:key_lookup].call

      raise KeyError, "No profiler found for key: #{key}" unless @cache.key?(key)

      @cache[key].accept_visitor(visitor, node)
    end
  end
end
