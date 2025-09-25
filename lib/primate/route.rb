# frozen_string_literal: true

require_relative 'request'
require_relative 'response'
require_relative '../primate'

# Route registration and handling
module Route
  @routes = {}

  # Register a GET route handler
  #
  # @yieldparam request [Request] The HTTP request object
  # @return [void]
  def self.get(&block)
    @routes['GET'] = block
  end

  # Register a POST route handler
  #
  # @yieldparam request [Request] The HTTP request object
  # @return [void]
  def self.post(&block)
    @routes['POST'] = block
  end

  # Register a PUT route handler
  #
  # @yieldparam request [Request] The HTTP request object
  # @return [void]
  def self.put(&block)
    @routes['PUT'] = block
  end

  # Register a PATCH route handler
  #
  # @yieldparam request [Request] The HTTP request object
  # @return [void]
  def self.patch(&block)
    @routes['PATCH'] = block
  end

  # Register a DELETE route handler
  #
  # @yieldparam request [Request] The HTTP request object
  # @return [void]
  def self.delete(&block)
    @routes['DELETE'] = block
  end

  # Register a HEAD route handler
  #
  # @yieldparam request [Request] The HTTP request object
  # @return [void]
  def self.head(&block)
    @routes['HEAD'] = block
  end

  # Register a OPTIONS route handler
  #
  # @yieldparam request [Request] The HTTP request object
  # @return [void]
  def self.options(&block)
    @routes['OPTIONS'] = block
  end

  # Register a CONNECT route handler
  #
  # @yieldparam request [Request] The HTTP request object
  # @return [void]
  def self.connect(&block)
    @routes['CONNECT'] = block
  end

  # Register a TRACE route handler
  #
  # @yieldparam request [Request] The HTTP request object
  # @return [void]
  def self.trace(&block)
    @routes['TRACE'] = block
  end

  # Get all registered routes
  #
  # @return [Hash] Hash of HTTP method => handler block
  def self.routes
    @routes
  end

  def self.set_session(session, helpers)
    PrimateInternal.set_session(session, helpers)
  end
  # Execute a route handler for the given HTTP method
  #
  # @param method [String] HTTP method
  # @param request [Request] Request object
  # @return [Object] Response from the route handler
  def self.call_route(method, request)
    handler = @routes[method.upcase]
    return Response.error(status: 404) unless handler

    handler.call(request)
  end
end
