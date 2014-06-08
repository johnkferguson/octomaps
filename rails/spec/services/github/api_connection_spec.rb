require 'spec_helper'

describe Github::APIConnection do
  let(:connection) { described_class.new }

  describe '#client' do
    it 'is an instance of Octokit::Client' do
      expect(connection.client).to be_a(Octokit::Client)
    end
  end

  describe '#rate_limit_remaining', :vcr do
    it 'returns an integer' do
      expect(connection.rate_limit_remaining).to be_a(Integer)
    end
  end
end
