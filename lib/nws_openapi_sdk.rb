# frozen_string_literal: true

require 'openapi3_parser'
require 'faraday'

require_relative 'nws_openapi_sdk/http_client'
require_relative 'nws_openapi_sdk/path_parser'
require_relative 'nws_openapi_sdk/version'

# NwsOpenapiSdk is a dynamically generated API client for the
# National Weather Service API.
# It consumes the OpenApi spec hosted at https://api.weather.gov/openapi.json
# and creates a method on the instantiated NwsOpenapiSdk::HttpClient
# for each operationId provided by the OpenAPI spec.
module NwsOpenapiSdk
  class Error < StandardError; end

  class << self
    def new(user_agent: 'set_me_to_avoid_security_disruptions')
      NwsOpenapiSdk::HttpClient.new(user_agent)
    end
  end
end
