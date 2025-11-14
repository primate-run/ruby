# frozen_string_literal: true

require 'json'
require_relative 'readable'
require_relative 'uploaded_file'

# Wrapper for request body with type-specific methods
class RequestBody
  # Initialize with JavaScript body object
  #
  # @param body [Object] JavaScript body object from runtime
  # @param helpers [Object] Helper functions from JavaScript runtime
  def initialize(body, helpers)
    @body = body
    @helpers = helpers
  end

  # Get body as JSON (parsed hash)
  #
  # @return [Hash] Parsed JSON data
  def json
    JSON.parse(@body.json.to_s)
  end

  # Get body as plain text
  #
  # @return [String] Body as string
  def text
    @body.text.to_s
  end

  # Get form as hash
  #
  # @return [Hash] Form data
  def form
    JSON.parse(@body.form.to_s)
  end

  def files
    files = @body.files

    Array.new(files[:length].to_i) do |i|
      f = files[i]
      Primate::UploadedFile.new(
        field: f['field'].to_s,
        name:  f['name'].to_s,
        type:  f['type'].to_s,
        size:  f['size'].to_i,
        bytes: f['bytes']
      )
    end
  end

  def binary
    binary = @body.binary
    Primate::Readable.new(binary['buffer'], binary['mime'].to_s)
  end
end
