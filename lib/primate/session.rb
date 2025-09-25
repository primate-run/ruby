# frozen_string_literal: true

# Session management helpers
module Session
  class << self
    attr_accessor :current

    # Set the current session instance (called by framework)
    #
    # @param session_instance [SessionInstance] Session instance from JavaScript runtime
    # @return [void]
    def set_current(session_instance)
      self.current = session_instance
    end

    # Get the session ID
    #
    # @return [String] Session identifier
    def id
      current&.id
    end

    # Check if session exists
    #
    # @return [Boolean] True if session exists
    def exists?
      current&.exists || false
    end

    # Create a new session with data
    #
    # @param data [Hash] Initial session data
    # @return [void]
    def create(data)
      current&.create(data)
    end

    # Get session data (raises if no session)
    #
    # @return [Hash] Session data
    def get
      current&.get || {}
    end

    # Try to get session data (returns empty if no session)
    #
    # @return [Hash] Session data or empty hash
    def try
      current&.try || {}
    end

    # Set session data
    #
    # @param data [Hash] Data to store in session
    # @return [void]
    def set(data)
      current&.set(data)
    end

    # Destroy the session
    #
    # @return [void]
    def destroy
      current&.destroy
    end
  end
end

# Internal session instance class (used by framework)
class SessionInstance
  # Initialize session with JavaScript session object and helpers
  #
  # @param session [Object] JavaScript session object from the runtime
  # @param helpers [Object] Helper functions from JavaScript runtime
  def initialize(session, helpers)
    @session = session
    @helpers = helpers
  end

  # Get the session ID
  #
  # @return [String] Session identifier
  def id
    @session['id']
  end

  # Check if session exists
  #
  # @return [Boolean] True if session exists
  def exists
    @session['exists']
  end

  # Create a new session with data
  #
  # @param data [Hash] Initial session data
  # @return [void]
  def create(data)
    @session.create(data)
  end

  # Get session data (raises if no session)
  #
  # @return [Hash] Session data
  def get
    @session.get
  end

  # Try to get session data (returns empty if no session)
  #
  # @return [Hash] Session data or empty hash
  def try
    @session.try
  end

  # Set session data
  #
  # @param data [Hash] Data to store in session
  # @return [void]
  def set(data)
    @session.set(data)
  end

  # Destroy the session
  #
  # @return [void]
  def destroy
    @session.destroy
  end
end
