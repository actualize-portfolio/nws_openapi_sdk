# frozen_string_literal: true

RSpec.describe NwsOpenapiSdk do
  subject(:sdk) { described_class.new(user_agent: user_agent) }

  let(:user_agent) { 'test' }
  let(:http_client) { instance_double(NwsOpenapiSdk::HttpClient) }

  before do
    allow(NwsOpenapiSdk::HttpClient).to receive(:new).and_return(http_client)
  end

  it 'has a version number' do
    expect(NwsOpenapiSdk::VERSION).not_to be_nil
  end

  describe '.new' do
    it 'passes the user_agent to a new NwsOpenapiSdk::HttpClient instance' do
      sdk

      expect(NwsOpenapiSdk::HttpClient).to have_received(:new).with('test')
    end

    it 'returns an NwsOpenapiSdk::HttpClient instance' do
      expect(sdk).to eq(http_client)
    end
  end
end
