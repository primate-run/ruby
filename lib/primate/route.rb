# frozen_string_literal: true

require_relative 'request'
require_relative 'response'
require_relative 'i18n'
require_relative '../primate'

module Route
  @registry = Hash.new { |h, k| h[k] = {} }
  @current_scope = "__global__"

  class << self
    def scope(id)
      @current_scope = id.to_s
      @registry[@current_scope]
    end

    def clear(id = nil)
      target = (id || @current_scope).to_s
      @registry.delete(target)
      @registry[target] = {}
    end

    def registry(id = nil)
      @registry[(id || @current_scope).to_s]
    end

    %w[GET POST PUT PATCH DELETE HEAD OPTIONS CONNECT TRACE].each do |verb|
      define_method(verb.downcase) do |content_type: nil, &block|
        raise ArgumentError, "block required" unless block
        registry[verb] = { handler: block, content_type: content_type }
      end
    end

    def set_session(session, helpers)
      PrimateInternal.set_session(session, helpers)
    end

    def set_i18n(i18n)
      I18N.set_current(i18n)
    end

    def call_js(scope_id, verb, js_req, helpers, session, i18n)
      set_session(session, helpers)
      set_i18n(i18n)

      verb_up = verb.to_s.upcase
      entry = @registry.dig(scope_id.to_s, verb_up)
      return Response.error(status: 404) unless entry

      request = Request.new(js_req, helpers)
      entry[:handler].call(request)
    end
  end
end
