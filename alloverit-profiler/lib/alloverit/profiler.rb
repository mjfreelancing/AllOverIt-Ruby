# frozen_string_literal: true

require_relative "profiler/profiler_root"

module AllOverIt
  module Profiler
    @cache = {}

    # Starts a profiling session with the given options and block.
    # Use of this method is optional. If used, it relies on :key_lookup of :cleanup is true
    #
    # @param options [Hash] Options for the profiling session.
    # @option options [Boolean] :cleanup Whether to clean up after profiling (default: false).
    # @option options [Proc] :key_lookup A proc to determine the cache key (default: -> { "default" }).
    # @yield The block to profile.
    # @return [Object] The result of the block.
    # @raise [ArgumentError] If no block is given.
    def self.start(options = {}, &block)
      raise ArgumentError, "A block must be provided to track" unless block_given?

      options[:cleanup] ||= false
      options[:key_lookup] ||= -> { "default" }

      @options = options

      result = block.call

      cleanup if options[:cleanup]

      result
    end

    # Profiles a block of code under a specific tag and cache key.
    #
    # @param tag [String] The tag for the profiling node.
    # @param lookup_key [String, nil] The cache key (optional).
    # @yield The block to profile.
    # @return [Object] The result of the block.
    # @raise [ArgumentError] If no block is given.
    def self.track(tag, lookup_key: nil, &block)
      raise ArgumentError, "A block must be provided to track" unless block_given?

      key = lookup_key || @options[:key_lookup].call

      @cache[key] ||= ProfilerRoot.new

      @cache[key].call(tag) do
        block.call
      end
    end

    # Adds a breadcrumb message to the current profiling node.
    #
    # @param lookup_key [String, nil] The cache key (optional).
    # @param message [String] The breadcrumb message.
    # @raise [KeyError] If no profiler is found for the key.
    def self.breadcrumb(lookup_key = nil, message)
      key = lookup_key || @options[:key_lookup].call

      raise KeyError, "No profiler found for key: #{key}" unless @cache.key?(key)

      @cache[key].breadcrumb(message)
    end

    # Cleans up the profiler cache for the given key.
    #
    # @param lookup_key [String, nil] The cache key (optional).
    def self.cleanup(lookup_key: nil)
      key = lookup_key || @options[:key_lookup].call
      @cache.delete(key)
    end

    # Accepts a visitor for traversing the profiling tree.
    #
    # @param lookup_key [String, nil] The cache key (optional).
    # @param visitor [Object] The visitor object.
    # @param node [Object, nil] The node to start from (optional).
    # @raise [KeyError] If no profiler is found for the key.
    def self.accept_visitor(lookup_key = nil, visitor, node: nil)
      key = lookup_key || @options[:key_lookup].call

      raise KeyError, "No profiler found for key: #{key}" unless @cache.key?(key)

      @cache[key].accept_visitor(visitor, node)
    end
  end
end
