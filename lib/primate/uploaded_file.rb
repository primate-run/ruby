# frozen_string_literal: true

require_relative 'readable'

module Primate
  class UploadedFile
    attr_reader :field, :filename, :content_type, :size

    def initialize(field:, name:, type:, size:, bytes:)
      @field = field
      @filename = name
      @content_type = type
      @size = size
      @io = Primate::Readable.new(bytes, type)
    end

    def io = @io
  end
end
