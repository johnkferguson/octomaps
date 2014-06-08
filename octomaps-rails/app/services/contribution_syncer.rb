# Repository full name
# Is it in already in the database?
  # YES/NO: Update the database with the info of the repository

  # Are any of the contributors in the database
    # YES: Create the relationship between the contributors and the database
    # NO: Do nothing
  # Are there any contributors who are not in the database?
    # YES: Create each of the missing contributors along with their relationship
    # to the repository
    # NO: Do nothing



class ContributionSyncer < Github::Connection
  def initialize(full_repo_name)
    @github_repository = Github::Repository.new(full_repo_name)
  end

  def create_contributed_relationships_for_existing_users
    matching_contributors_by(persisted_contributor_usernames).each do |contributor|
      create_contributed_relationship(contributor, persisted_repository)
    end
  end

  def update_database_based_upon_github
  end

  private

  attr_reader :github_repository

  def persisted_repository
    @persisted_repository ||= RepositoryUpdater.new(github_repository).perform
  end

  def repository_name
    persisted_repository.full_name
  end

  def github_contributors
    github_repository.contributors
  end

  def github_contributor_usernames
    github_contributors.collect { |contributor| contributor.login }
  end

  def persisted_contributor_usernames
    Person.persisted_usernames_in(github_contributor_usernames)
  end

  def matching_contributors_by(usernames)
    @matching_contributors ||= github_contributors.select do |contributor|
      usernames.include?(contributor.login)
    end
  end

  def create_contributed_relationship(contributor, repository)
    Neo4j::Session.query("
    MATCH (person:Person {github_username: '#{contributor.login}'})
    MATCH (repo:Repository {full_name: '#{repository.full_name}'})
    CREATE UNIQUE (person)-[:contributed_to {commits: #{contributor.contributions}}]->(repo);
    ")
  end
end
