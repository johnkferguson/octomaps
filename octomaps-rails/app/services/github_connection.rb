class GithubConnection
  def client
    @client ||= begin
      config_file = File.expand_path(File.join(__FILE__, "../../../config/github.yml"))
      config ||= YAML.load(ERB.new(File.read(config_file)).result)
      Octokit::Client.new(client_id: config['client_id'], client_secret: config['client_secret'])
    end
  end

  def rate_limit_remaining
    client.rate_limit.remaining
  end
end
