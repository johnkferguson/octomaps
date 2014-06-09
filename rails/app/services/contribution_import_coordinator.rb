class ContributionImportCoordinator
  def initialize(full_repo_name)
    @github_repository = Github::Repository.new(full_repo_name)
  end

  def update_database_based_upon_github
    update_or_create_repository
    create_needed_contributed_to_relationships_for_existing_users
    create_new_persons_and_relationships
  end

  private

  attr_reader :github_repository

  def github_contributors
    github_repository.contributors
  end

  def github_contributor_usernames
    github_contributors.collect { |contributor| contributor.login }
  end

  def persisted_repository
    @persisted_repository ||=
      Neo4jConnection::RepositoryUpdater.new(github_repository).perform
  end
  alias_method :update_or_create_repository, :persisted_repository

  def repository_name
    persisted_repository.full_name
  end

  def persisted_contributor_usernames
    Person.persisted_usernames_from(usernames_array: github_contributor_usernames)
  end

  def create_needed_contributed_to_relationships_for_existing_users
    persisted_contributors_lacking_relationship.each do |contributor|
      create_contributed_to_relationship(contributor)
    end
  end

  def persisted_contributors_lacking_relationship
    @persisted_contributors_lacking_relationship ||=
      github_contributors.select do |contributor|
        persisted_contributor_usernames.include?(contributor.login)
      end
  end

  def unpersisted_contributors
    @unpersisted_contributors ||=
      github_contributors - persisted_contributors_lacking_relationship
  end

  def create_contributed_to_relationship(contributor)
    Neo4j::Session.query("
    MATCH (person:Person {github_username: '#{contributor.login}'})
    MATCH (repo:Repository {full_name: '#{persisted_repository.full_name}'})
    CREATE UNIQUE (person)-[:`Person#contributed_to` {commits: #{contributor.contributions}}]->(repo);
    ")
  end

  def create_new_persons_and_relationships
    unpersisted_contributors.each do |contributor|
      Neo4j::Session.query("
        MATCH (repo:Repository {full_name: '#{persisted_repository.full_name}'})
        CREATE (person:Person {
          github_username: '#{contributor.login}',
          github_id: '#{contributor.id}',
          avatar_url: '#{contributor.avatar_url}',
          gravatar_id: '#{contributor.gravatar_id}'
        })-[:`Person#contributed_to` {commits: #{contributor.contributions}}]->(repo);
      ")
    end
  end
end
