# frozen_string_literal: true

module Ruzbx
  # TODO
  class Connection
    def initialize
      @token = Configuration.token
      @options = {
        url: Configuration.url
      }
    end

    def run
      Faraday.new(@options) do |builder|
        builder.request :json
        builder.response :json
        builder.response :raise_error
        builder.response :logger if Configuration.debug
      end
    end
  end
end
