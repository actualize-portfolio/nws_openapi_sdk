# National Weather Service OpenApi SDK

The National Weather Service hosts an API with tons of valuable and public data. They also provide an OpenAPI specification for that API at https://api.weather.gov/openapi.json. This Gem provides an extremely simple interface for consuming that API, not though predefined methods, but by reading the OpenAPI specification and meta-programming an http client instance with all the operationIds from the OpenAPI specification becoming `singleton_instance_method`s.

**The major benefit of this approach is that the Gem will automatically stay up to date with the API.**

While this Gem provides an interface for the API, one should still become familiar with the API's abilities. Please see the interactive documentation at https://www.weather.gov/documentation/services-web-api under the 'Specification' tab.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add nws_openapi_sdk

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install nws_openapi_sdk

## Usage

Create an instance of the Gem's main module and provide the `user_agent`. This will become a header in the request and is how the API distinguishes you calls from other calls. The `user_agent` value should be a unique ID such as a UUID you have configured as an environment variable.

```ruby
api_client = NwsOpenapiSdk.new(user_agent: ENV['NWS_USER_AGENT'])
```

After the instance is created, inspect the public methods available

```ruby
api_client.public_methods
=> [
 :alerts_active,
 :alerts_active_count,
 :alerts_active_zone,
 :alerts_active_area,
 :alerts_active_region,
 :alerts_types,
 :alerts_single,
 :glossary,
 ...
]
```

All of the API's operationIds have been programmed on the instance as singleton methods. Call any of them to learn about the arguments needed.

```ruby
api_client.alerts_active_region
=>
  api_client.alerts_active_region
  nws_openapi_sdk/lib/nws_openapi_sdk/path_parser.rb:64:in `fetch': key not found: :region (KeyError)
```

Try the call again but provide the required keyword argument. While the instance is smart enough to know what keys it needs for a method, it cannot help with values. Those you'll need to research what the API expects.

```ruby
api_client.alerts_active_region(region: 'AL')
=> {"@context"=>["https://geojson.org/geojson-ld/geojson-context.jsonld" ...
```

You can also infer the keyword arguments by reading the path definition for than operation. If the path was `/foo/{a}/{b},{c}/{x}`, the method call would require 4 keyword args like

```ruby
api_client.fake_foo_method(a: 'biz', b: 'baz', c: 'zing', x: 'zang')
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/nws_openapi_sdk. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/nws_openapi_sdk/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the NwsOpenapiSdk project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/nws_openapi_sdk/blob/main/CODE_OF_CONDUCT.md).
