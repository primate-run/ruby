# frozen_string_literal: true

require_relative "primate/version"

module PrimateInternal
  def self.set_session(session, helpers)
    require_relative "primate/session"
    session_instance = SessionInstance.new(session, helpers)
    Session.set_current(session_instance)
  end
end
