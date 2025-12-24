# frozen_string_literal: true

# Internationalization support
module I18N
  @current = nil

  class << self
    # Set the current i18n instance (called by framework)
    #
    # @param i18n_obj [Object] JavaScript i18n object from the runtime
    # @return [void]
    def set_current(i18n_obj)
      @current = i18n_obj
    end

    # Translate a key with optional parameters
    #
    # @param key [String] Translation key
    # @param params [Hash] Interpolation parameters
    # @return [String] Translated string
    def t(key, params = nil)
      return key unless @current

      if params.nil?
        @current.t(key)
      else
        @current.t(key, params.to_json)
      end
    end

    # Locale accessor
    #
    # @return [Locale] Locale accessor object
    def locale
      Locale
    end
  end

  # Locale accessor module
  module Locale
    class << self
      # Get the current locale
      #
      # @return [String] Current locale code
      def get
        I18N.instance_variable_get(:@current)&.[]('locale')
      end

      # Set the current locale
      #
      # @param value [String] Locale code to set
      # @return [void]
      def set(value)
        I18N.instance_variable_get(:@current)&.set(value)
      end
    end
  end
end
