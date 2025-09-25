# frozen_string_literal: true

module Primate
  class Readable
    attr_reader :content_type

    def initialize(typed_array, content_type = nil)
      @ta = typed_array
      @content_type = content_type
      @pos = 0
      @size = @ta[:length].to_i
    end

    def size = @size
    def eof? = @pos >= @size
    def rewind; @pos = 0; self; end

    # return a binary string (ASCII-8BIT), advance position
    def read(n = nil)
      return ''.b if eof?
      n = n ? [n, @size - @pos].min : (@size - @pos)
      str = pack_range(@pos, n)
      @pos += n
      str
    end

    # return an array of bytes (integers), advance position
    def bytes(n = nil)
      return [] if eof?
      n = n ? [n, @size - @pos].min : (@size - @pos)
      arr = Array.new(n) { |i| @ta[@pos + i].to_i }
      @pos += n
      arr
    end

    # look ahead without advancing position (integers)
    def peek(n)
      n = [n, @size - @pos].min
      Array.new(n) { |i| @ta[@pos + i].to_i }
    end

    # first n bytes from the beginning (integers), does not affect position
    def head(n = 4)
      n = [n, @size].min
      Array.new(n) { |i| @ta[i].to_i }
    end

    # enumerate binary string chunks starting at current position (no rewind)
    def each_chunk(chunk = 64 * 1024)
      return enum_for(:each_chunk, chunk) unless block_given?
      off = @pos
      while off < @size
        n = [chunk, @size - off].min
        yield pack_range(off, n)
        off += n
      end
      self
    end

    private

    def pack_range(off, n)
      Array.new(n) { |i| @ta[off + i].to_i }.pack('C*')
    end
  end
end
