module GithubConnection
  def client
    @client ||= Octokit::Client.new(login: LOGIN, password: PASSWORD)
  end

  def rate_limit_remaining
    client.rate_limit.remaining 
  end
end