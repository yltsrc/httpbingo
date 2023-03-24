# frozen_string_literal: true

require 'faraday'

module Httpbingo
  class Client
    attr_reader :client

    def initialize
      @client = Faraday.new(url: 'http://httpbingo.org')
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
