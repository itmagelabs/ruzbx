# frozen_string_literal: true

module Ruzbx
  # TODO
  class Entity
    def initialize
      @token = Configuration.token
      @method = :POST
      @rpc_method = nil
      @params = {}
      @headers = { 'Content-Type': 'application/json' }
      @data = { "jsonrpc": '2.0', "id": rand(1000) }
      @auth = { 'Authorization': "Bearer #{@token}" }
      @rest_api = nil
    end

    def self.build(&block)
      entity = new
      return entity unless block_given?

      entity.instance_eval(&block)

      entity
    end

    def no_auth
      @auth = {}
    end

    def params(params)
      @params = params
    end

    def headers(headers)
      @headers = headers
    end

    def method(method)
      @method = method
    end

    def path(path = 'api_jsonrpc.php')
      @path ||= "#{@rest_api}/#{path}"

      return @path if @path

      raise ArgumentError, "No argument to 'path' was given."
    end

    def rpc_method(method)
      @rpc_method = { method: method }
    end

    def data(data = {})
      @data.merge!(data)

      return @data if @data

      raise ArgumentError, "No argument to 'data' was given."
    end

    def commit
      case @method
      when :POST
        post.body
      end
    end

    private

    def request
      yield
    rescue Faraday::Error => e
      raise "Status #{e.response[:status]}: #{e.response[:body]}"
    end

    def post
      request do
        client.post path do |req|
          req.headers = @headers.merge(@auth)
          req.params = @params
          req.body = @data.merge(@rpc_method)
        end
      end
    end

    def client
      conn = Ruzbx::Connection.new
      conn.run
    end
  end
end
