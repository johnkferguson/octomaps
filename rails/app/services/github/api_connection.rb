module Github
  class APIConnection
    def client
      @client ||= begin
        Octokit::Client.new(
          client_id: config['client_id'],
          client_secret: config['client_secret']
        )
      end
    end

    def rate_limit_remaining
      client.rate_limit.remaining
    end

    private

    def not_found
      @not_found ||= NullObject.new
    end

    def config
      @config ||= YAML.load(ERB.new(File.read(config_file)).result)
    end

    def config_file
      File.expand_path(File.join(__FILE__, '../../../../config/github.yml'))
    end
  end
end
