# frozen_string_literal: true

require_relative 'url'
require_relative 'request_bag'
require_relative 'request_body'

class Request
  attr_reader :url, :body, :path, :query, :headers, :cookies

  # @param request [Object] JavaScript request object from the runtime
  # @param helpers [Object] Helper functions from JavaScript runtime
  def initialize(request, helpers)
    @url = Primate::URL.new(request['url'])
    @body = RequestBody.new(request['body'], helpers)
    @path = RequestBag.new(request['path'], helpers)
    @query = RequestBag.new(request['query'], helpers)
    @headers = RequestBag.new(request['headers'], helpers)
    @cookies = RequestBag.new(request['cookies'], helpers)
  end
end
