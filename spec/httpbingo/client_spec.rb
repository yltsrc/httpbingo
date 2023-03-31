# frozen_string_literal: true

RSpec.describe Httpbingo::Client do
  describe '.bearer' do
    it "returns unauthorized response" do
      expect { subject.bearer }.to raise_error(Httpbingo::Unauthorized)
    end

    it "returns success response" do
      response = subject.bearer('asdf')
      expect(response[:authenticated]).to be_truthy
    end
  end

  describe '.cache' do
    it "returns success response" do
      response = subject.cache
      expect(response[:args]).to eql({})
    end

    it "returns cached response" do
      response = subject.cache('Fri, 24 Mar 2023 08:18:22 UTC')
      expect(response).to eql({})
    end
  end

  describe '.status' do
    it "returns success response" do
      response = subject.status(200)
      expect(response).to eql(status: 'ok')
    end

    it "fails with client error" do
      expect { subject.status(404) }.to raise_error(Httpbingo::ClientError)
    end

    it "fails with server error" do
      expect { subject.status(503) }.to raise_error(Httpbingo::ServerError)
    end
  end

  describe '.uuid' do
    it "returns uuid" do
      response = subject.uuid
      expect(response).to be_an_instance_of(Httpbingo::UUID)
      expect(response.value).to match(/\A(urn:uuid:)?[\da-f]{8}-([\da-f]{4}-){3}[\da-f]{12}\z/i)
    end
  end
end
