require 'spec_helper'

describe Github::APIConnection do
  let(:connection) { described_class.new }

  describe '#client' do
    it 'is an instance of Octokit::Client' do
      expect(connection.client).to be_a(Octokit::Client)
    end

    context 'when application auth env variables have been configured' do
      before do
        stub_const(
          'ENV', 'GITHUB_CLIENT_ID' => 'id', 'GITHUB_CLIENT_SECRET' => 'secret'
        )
      end

      it 'authenticates via application auth' do
        expect(connection.client.application_authenticated?).to eq true
      end
    end

    context 'when application auth env variables have not been configured' do
      before do
        stub_const(
          'ENV', 'GITHUB_CLIENT_ID' => nil, 'GITHUB_CLIENT_SECRET' => nil
        )
      end

      context 'when basic auth env variables have been configured' do
        before do
          stub_const(
            'ENV',
            'GITHUB_USERNAME' => 'username', 'GITHUB_PASSWORD' => 'password'
          )
        end

        it 'authenticates via basic auth' do
          expect(connection.client.basic_authenticated?).to eq true
        end
      end

      context 'when basic auth env variables have not been configured' do
        before do
          stub_const('ENV', 'GITHUB_USERNAME' => nil, 'GITHUB_PASSWORD' => nil)
        end

        it 'raises a Github Authentication error' do
          expect { connection.client }
            .to raise_error(
              Github::AuthenticationError,
              'Please configure your correct Github authentication details '\
              'in your .env file'
            )
        end
      end
    end
  end

  describe '#rate_limit_remaining', :vcr do
    it 'returns an integer' do
      expect(connection.rate_limit_remaining).to be_a(Integer)
    end
  end
end
