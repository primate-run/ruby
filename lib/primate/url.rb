# frozen_string_literal: true

module Primate
  class URL
    attr_reader :href, :origin, :protocol, :username, :password, :host,
                :hostname, :port, :pathname, :search, :hash

    # initialize URL from JavaScript URL object
    # @param url [Object] JavaScript URL object from the runtime
    def initialize(url)
      @href = url['href'].to_s
      @origin = url['origin'].to_s
      @protocol = url['protocol'].to_s
      @username = url['username'].to_s
      @password = url['password'].to_s
      @host = url['host'].to_s
      @hostname = url['hostname'].to_s
      @port = url['port'].to_s
      @pathname = url['pathname'].to_s
      @search = url['search'].to_s
      @hash = url['hash'].to_s
    end
  end
end
