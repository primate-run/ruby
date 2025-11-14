# frozen_string_literal: true

require_relative 'request'
require_relative 'response'
require_relative '../primate'

module Route
  @registry = Hash.new { |h, k| h[k] = {} }
  @current_scope = "__global__"

  class << self
    # set the active scope for subsequent handler registrations
    def scope(id)
      @current_scope = id.to_s
      @registry[@current_scope]
    end

    # clear routes for a specific scope (or the current scope if none given)
    def clear(id = nil)
      target = (id || @current_scope).to_s
      @registry.delete(target)
      @registry[target] = {}
    end

    # return the verb->handler map for a scope (read-only use)
    def registry(id = nil)
      @registry[(id || @current_scope).to_s]
    end

    %w[GET POST PUT PATCH DELETE HEAD OPTIONS CONNECT TRACE].each do |verb|
      define_method(verb.downcase) do |&block|
        raise ArgumentError, "block required" unless block
        registry[verb] = block
      end
    end

    def set_session(session, helpers)
      PrimateInternal.set_session(session, helpers)
    end

    def call_js(scope_id, verb, js_req, helpers, session)
      set_session(session, helpers)
      request = Request.new(js_req, helpers)

      verb_up = verb.to_s.upcase
      handler = @registry.dig(scope_id.to_s, verb_up)
      return Response.error(status: 404) unless handler

      handler.call(request)
    end
  end
end
