# frozen_string_literal: true

require 'faraday'

module Httpbingo
  class Client
    attr_reader :client

    def initialize
      @client = Faraday.new(url: 'http://httpbingo.org') do |conn|
        conn.response :raise_error
      end
    end

    def bearer(token = nil)
      headers = { 'Content-Type' => 'application/json' }
      headers['Authorization'] = "Bearer #{token}" if token
      response = client.get('/bearer', {}, headers)
      JSON.parse(response.body, symbolize_names: true)
    end

    def cache(if_modified_since = nil)
      headers = { 'Content-Type' => 'application/json' }
      headers['If-Modified-Since'] = if_modified_since if if_modified_since
      response = client.get('/cache', {}, headers)
      if response.status == 200
        JSON.parse(response.body, symbolize_names: true)
      else
        {}
      end
    end
  end
end
