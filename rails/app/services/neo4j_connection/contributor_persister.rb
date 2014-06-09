module Neo4jConnection
  class ContributorPersister
    def initialize(contributor:, repository_name:)
      @contributor = contributor
      @repository_name = repository_name
    end

    def perform
      Neo4j::Session.query("
        MATCH (repo:Repository {full_name: '#{repository_name}'})
        CREATE (person:Person
          {
            github_username: '#{contributor.login}',
            github_id: '#{contributor.id}',
            avatar_url: '#{contributor.avatar_url}',
            gravatar_id: '#{contributor.gravatar_id}'
          }
        )
        -[:`Person#contributed_to` { commits: #{contributor.contributions} }]
        ->(repo);
      ")
    end

    private

    attr_reader :contributor, :repository_name
  end
end
