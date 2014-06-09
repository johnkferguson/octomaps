module Neo4jConnection
  class ContributionConnector
    def initialize(contributor:, repository_name:)
      @contributor = contributor
      @repository_name = repository_name
    end

    def perform
      Neo4j::Session.query("
        MATCH (person:Person {github_username: '#{contributor.login}'})
        MATCH (repo:Repository {full_name: '#{repository_name}'})
        CREATE UNIQUE (person)
          -[:`Person#contributed_to` {commits: #{contributor.contributions}}]
          ->(repo);
      ")
    end

    private

    attr_reader :contributor, :repository_name
  end
end
