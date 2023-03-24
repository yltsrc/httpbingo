# frozen_string_literal: true

require_relative "httpbingo/version"
require_relative "httpbingo/client"

module Httpbingo
  class Error < StandardError; end
  class ClientError < StandardError; end
  class ServerError < StandardError; end
  class Unauthorized < ClientError; end
end
