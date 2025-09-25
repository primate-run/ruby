# frozen_string_literal: true

module Pema
  class ValidationError < StandardError; end

  class Field
    def parse(value, coerce = false)
      raise NotImplementedError, 'Subclasses must implement parse'
    end
  end

  class StringType < Field
    def parse(value, coerce = false)
      return value if value.is_a?(String)

      if coerce
        return value.to_s
      end

      raise ValidationError, "expected string, got #{value.class}"
    end
  end

  class BooleanType < Field
    def parse(value, coerce = false)
      return value if value.is_a?(TrueClass) || value.is_a?(FalseClass)

      if coerce
        case value
        when String
          return false if value.empty?
          case value.downcase
          when 'true', '1', 'yes', 'on'
            return true
          when 'false', '0', 'no', 'off'
            return false
          else
            raise ValidationError, "cannot parse '#{value}' as boolean"
          end
        else
          raise ValidationError, "cannot coerce #{value.class} to boolean"
        end
      end

      raise ValidationError, "expected boolean, got #{value.class}"
    end
  end

  class IntType < Field
    def parse(value, coerce = false)
      return value if value.is_a?(Integer)

      if coerce
        case value
        when Float
          return value.to_i
        when String
          return 0 if value.empty?
          return Integer(value)
        else
          raise ValidationError, "cannot coerce #{value.class} to int"
        end
      end

      raise ValidationError, "expected integer, got #{value.class}"
    rescue ArgumentError
      raise ValidationError, "cannot parse '#{value}' as integer"
    end
  end

  class FloatType < Field
    def parse(value, coerce = false)
      return value if value.is_a?(Float)

      if coerce
        case value
        when Integer
          return value.to_f
        when String
          return 0.0 if value.empty?
          return Float(value)
        else
          raise ValidationError, "cannot coerce #{value.class} to float"
        end
      end

      raise ValidationError, "expected float, got #{value.class}"
    rescue ArgumentError
      raise ValidationError, "cannot parse '#{value}' as float"
    end
  end

  def self.string
    StringType.new
  end

  def self.boolean
    BooleanType.new
  end

  def self.int
    IntType.new
  end

  def self.float
    FloatType.new
  end

  class Schema
    def initialize(fields)
      @fields = fields
    end

    def parse(data, coerce = false)
      result = {}

      @fields.each do |name, field|
        value = data.key?(name) ? data[name] : ''

        begin
          result[name] = field.parse(value, coerce)
        rescue ValidationError => e
          raise ValidationError, "parsing failed for field '#{name}': #{e.message}"
        end
      end

      result
    end
  end

  def self.schema(fields)
    Schema.new(fields)
  end
end
