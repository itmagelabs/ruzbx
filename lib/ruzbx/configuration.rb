# frozen_string_literal: true

module Ruzbx
  # TODO
  module Configuration
    def self.username
      return ENV['RUZBX_USERNAME'] if ENV.include?('RUZBX_USERNAME')

      raise 'The environment variable RUZBX_USERNAME is not set'
    end

    def self.password
      return ENV['RUZBX_PASSWORD'] if ENV.include?('RUZBX_PASSWORD')

      raise 'The environment variable RUZBX_PASSWORD is not set'
    end

    def self.token
      return ENV['RUZBX_TOKEN'] if ENV.include?('RUZBX_TOKEN')

      raise 'The environment variable RUZBX_TOKEN is not set'
    end

    def self.url
      return ENV['RUZBX_URL'] if ENV.include?('RUZBX_URL')

      'http://localhost:8080'
    end

    def self.debug
      return false unless ENV.include?('RUZBX_DEBUG')

      ENV['RUZBX_DEBUG'].match?(/^true$/)
    end
  end
end
