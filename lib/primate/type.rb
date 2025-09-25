# frozen_string_literal: true

require 'json'

def type(value, helpers)
  type = helpers.type(value).to_s

  if type == 'integer'
    return value.to_i
  end

  if type == 'float'
    return value.to_f
  end

  if type == 'boolean'
    return value == JS::True
  end

  if type == 'string'
    return value.to_s
  end

  if type == 'nil'
    return nil
  end

  if type == 'array'
    as_array = JS.global[:Array].from(value)
    return Array.new(as_array[:length].to_i) {
      type(as_array[_1], helpers)
    }
  end

  if type == 'object'
    as_entries = JS.global[:Object].entries(value)
    return Hash[Array.new(as_entries[:length].to_i) {[
      as_entries[_1][0].to_s,
      type(as_entries[_1][1], helpers)
    ]}]
  end

  value
end
