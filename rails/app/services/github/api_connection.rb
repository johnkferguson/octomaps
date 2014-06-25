module Github
  class AuthenticationError < StandardError; end
  class APIConnection
    def client
      @client ||= Octokit::Client.new(authentication_credentials)
    end

    def rate_limit_remaining
      client.rate_limit.remaining
    end

    private

    def not_found
      @not_found ||= NullObject.new
    end

    def authentication_credentials
      if application_auth?
        application_auth_credentials
      elsif basic_auth?
        basic_auth_credentials
      else
        raise Github::AuthenticationError,
              'Please configure your correct Github authentication details '\
              'in your .env file'
      end
    end

    def application_auth?
      ENV['GITHUB_CLIENT_ID'] && ENV['GITHUB_CLIENT_SECRET']
    end

    def application_auth_credentials
      {
        client_id: ENV['GITHUB_CLIENT_ID'],
        client_secret: ENV['GITHUB_CLIENT_SECRET']
      }
    end

    def basic_auth?
      ENV['GITHUB_USERNAME'] && ENV['GITHUB_PASSWORD']
    end

    def basic_auth_credentials
      { login: ENV['GITHUB_USERNAME'], password: ENV['GITHUB_PASSWORD'] }
    end
  end
end
