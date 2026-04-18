# frozen_string_literal: true

require 'json'
require_relative 'readable'
require_relative 'uploaded_file'

class Multipart
  attr_reader :form, :files

  def initialize(form, files)
    @form = form
    @files = files
  end
end

class RequestBody
  def initialize(body, helpers)
    @body = body
    @helpers = helpers
  end

  def json
    JSON.parse(@body.jsonSync.to_s)
  end

  def text
    @body.textSync.to_s
  end

  def form
    JSON.parse(@body.formSync.to_s)
  end

  def multipart
    form = JSON.parse(@body.formSync.to_s)
    files_js = @body.filesSync
    files = Array.new(files_js[:length].to_i) do |i|
      f = files_js[i]
      Primate::UploadedFile.new(
        field: f['field'].to_s,
        name:  f['name'].to_s,
        type:  f['type'].to_s,
        size:  f['size'].to_i,
        bytes: f['bytes']
      )
    end
    Multipart.new(form, files)
  end

  def blob
    Primate::Readable.new(@body.blobSync, @body.blobTypeSync.to_s)
  end
end
