class RetrieveGithubRepository
  @@octokit_client = Octokit::Client.new(:login => "flatiron-001",
                                         :password => "flatiron001")


end