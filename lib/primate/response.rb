# frozen_string_literal: true

module Response
  # Create a view response
  #
  # @param name [String] The view template name
  # @param props [Hash] Props to pass to the view
  # @param options [Hash] Additional view options
  # @return [Hash] Response object for the Primate framework
  def self.view(name, props = {}, options = {})
    { __PRMT__: 'view', name: name, props: props, options: options }
  end

  # Create a redirect response
  #
  # @param location [String] URL to redirect to
  # @param options [Hash] Redirect options (status code, etc.)
  # @return [Hash] Response object for the Primate framework
  def self.redirect(location, options = {})
    { __PRMT__: 'redirect', location: location, options: options }
  end

  # Create an error response
  #
  # @param options [Hash] Error options
  # @return [Hash] Response object for the Primate framework
  def self.error(options = {})
    { __PRMT__: 'error', options: options }
  end
end
