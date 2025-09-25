# frozen_string_literal: true

require_relative 'type'

class RequestBag
  # initialize with JavaScript object data
  #
  # @param data [Object] JavaScript object from runtime
  def initialize(data, helpers)
    @data = type(data, helpers)
  end

  # get a value by key
  #
  # @param key [String] The key to look up
  # @return [String] The value as string
  # @throws RuntimeError if key is missing
  def get(key)
    raise "RequestBag has no key #{key}" unless has?(key)
    @data[key].to_s
  end

  # Get a value by key (alias for get, Ruby style)
  def [](key)
    get(key)
  end

  # Try to get a value by key
  #
  # @param key [String] The key to look up
  # @return [String, nil] The value or nil if absent
  def try(key)
    has?(key) ? @data[key].to_s : nil
  end

  # Whether the bag contains a defined value for the key
  #
  # @param key [String] The key to check
  # @return [Boolean] True if key exists with defined value
  def has?(key)
    @data.key?(key) && !@data[key].nil?
  end

  # Parse the entire bag with a schema
  #
  # @param schema [Object] Object with parse method
  # @param coerce [Boolean] Whether to coerce types
  # @return [Object] Parsed result
  def parse(schema, coerce = false)
    schema.parse(@data, coerce)
  end

  # Convert to hash (Ruby standard conversion)
  #
  # @return [Hash] The underlying data
  def to_h
    @data
  end

  # Size of the bag
  #
  # @return [Integer] Number of entries
  def size
    @data.size
  end
end
