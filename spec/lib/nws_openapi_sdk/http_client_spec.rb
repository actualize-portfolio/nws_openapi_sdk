# frozen_string_literal: true

RSpec.describe NwsOpenapiSdk::HttpClient do
  subject(:nws_api) { described_class.new(user_agent) }

  let!(:user_agent) { 'test' }
  let!(:openapi) { Openapi3Parser.load_file('spec/fixtures/openapi.json') }

  let(:stubs) { Faraday::Adapter::Test::Stubs.new }
  let(:conn) { Faraday.new { |b| b.adapter(:test, stubs) } }
  let(:mock_response) do
    [
      200,
      { 'Content-Type': 'application/javascript' },
      '{}'
    ]
  end

  before do
    allow(Openapi3Parser).to receive(:load_url).and_return(openapi)
    allow(Faraday).to receive(:new).and_return(conn)
  end

  after { stubs.verify_stubbed_calls }

  describe 'metaprogrammed methods' do
    it '#alerts_query' do
      stubs.get('/alerts') { mock_response }
      nws_api.alerts_query
    end

    it '#alerts_active_region' do
      stubs.get('/alerts/active/region/AL') { mock_response }
      nws_api.alerts_active_region(region: 'AL')
    end
  end
end
