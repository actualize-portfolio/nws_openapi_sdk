# frozen_string_literal: true

require_relative 'lib/nws_openapi_sdk/version'

Gem::Specification.new do |spec|
  spec.name = 'nws_openapi_sdk'
  spec.version = NwsOpenapiSdk::VERSION
  spec.authors = ['James Gates']
  spec.email = ['gatorjuice@gmail.com']

  spec.summary = 'Nation Weather Service OpenAPI SDK'
  spec.description = 'Reads the NWS OpenAPI definition and creates a client to interact with its API'
  spec.homepage = 'https://github.com/actualize-portfolio/nws_openapi_sdk'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/actualize-portfolio/nws_openapi_sdk'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rake'
  spec.add_development_dependency 'rubocop-rspec'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
