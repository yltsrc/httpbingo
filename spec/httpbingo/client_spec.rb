# frozen_string_literal: true

RSpec.describe Httpbingo::Client do
  describe '.cache' do
    it "returns success response" do
      response = subject.cache
      expect(response[:args]).to eql({})
    end

    it "returns success response" do
      response = subject.cache('Fri, 24 Mar 2023 08:18:22 UTC')
      expect(response).to eql({})
    end
  end
end
