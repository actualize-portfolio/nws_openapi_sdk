# frozen_string_literal: true

module NwsOpenapiSdk
  # A meta-programmed class that calls the API. After being instantiated,
  # the instance will possess a method for every operationId in the API.
  # The method will accept keyword arguments that corresponed to the {}
  # placeholder values in the path.
  class HttpClient
    attr_reader :user_agent, :openapi

    BASE_URL = 'https://api.weather.gov'

    def initialize(user_agent)
      @user_agent = user_agent
      @openapi = Openapi3Parser.load_url("#{BASE_URL}/openapi.json")

      create_methods!
    end

    private

    def create_methods!
      openapi.paths.each do |path, path_item|
        define_singleton_method(path_item.get.operation_id) do |**args|
          response = faraday_client.get(NwsOpenapiSdk::PathParser.parse(path, **args))
          response.success? ? JSON.parse(response.body) : response
        end
      end
    end

    def faraday_client
      @faraday_client ||= Faraday.new(url: BASE_URL) do |conn|
        conn.headers['User-Agent'] = user_agent
      end
    end
  end
end
