# frozen_string_literal: true

RSpec.describe Httpbingo::Client do
  describe '.bearer' do
    it "returns unauthorized response" do
      expect { subject.bearer }.to raise_error(Faraday::UnauthorizedError)
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
end
