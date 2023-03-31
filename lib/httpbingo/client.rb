# frozen_string_literal: true

require 'faraday'

module Httpbingo
  class Client
    attr_reader :client

    def initialize
      @client = Faraday.new(url: 'http://httpbingo.org') do |conn|
        # conn.response :raise_error
      end
    end

    def bearer(token = nil)
      headers = { 'Content-Type' => 'application/json' }
      headers['Authorization'] = "Bearer #{token}" if token
      response = client.get('/bearer', {}, headers)
      case response.status
      when 200
        JSON.parse(response.body, symbolize_names: true)
      when 401
        raise Httpbingo::Unauthorized, response.body
      else
        raise Httpbingo::Error, response.inspect
      end
    end

    def cache(if_modified_since = nil)
      headers = { 'Content-Type' => 'application/json' }
      headers['If-Modified-Since'] = if_modified_since if if_modified_since
      response = client.get('/cache', {}, headers)
      case response.status
      when 200
        JSON.parse(response.body, symbolize_names: true)
      when 304
        {}
      else
        raise Httpbingo::Error, response.inspect
      end
    end

    def status(code)
      response = client.get("/status/#{code}")
      case response.status
      when 200
        { status: 'ok' }
      when 400..499
        raise Httpbingo::ClientError, response.body
      when 500..599
        raise Httpbingo::ServerError, response.body
      else
        raise Httpbingo::Error, response.inspect
      end
    end

    def uuid
      response = client.get("/uuid")
      case response.status
      when 200
        data = JSON.parse(response.body, symbolize_names: true)
        Httpbingo::UUID.new(data[:uuid])
      else
        raise Httpbingo::Error, response.inspect
      end
    end
  end
end
