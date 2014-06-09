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

  attr_reader :github_repository, :persisted_repository

  def update_or_create_repository
    @persisted_repository ||=
      Neo4jConnection::RepositoryUpdater.new(github_repository).perform
  end

  def create_needed_contributed_to_relationships_for_existing_users
    persisted_contributors_lacking_relationship.each do |contributor|
      Neo4jConnection::ContributionConnector.new(
        contributor: contributor, repository_name: repository_name
      ).perform
    end
  end

  def create_new_persons_and_relationships
    unpersisted_contributors.each do |contributor|
      Neo4jConnection::ContributorPersister.new(
        contributor: contributor,
        repository_name: repository_name
      ).perform
    end
  end

  def persisted_contributors_lacking_relationship
    @persisted_contributors_lacking_relationship ||=
      github_contributors.select do |contributor|
        persisted_contributor_usernames.include?(contributor.login)
      end
  end

  def github_contributors
    github_repository.contributors
  end

  def persisted_contributor_usernames
    Person.persisted_usernames_from(
      usernames_array: github_contributor_usernames
    )
  end

  def github_contributor_usernames
    github_contributors.collect { |contributor| contributor.login }
  end

  def repository_name
    persisted_repository.full_name
  end

  def unpersisted_contributors
    @unpersisted_contributors ||=
      github_contributors - persisted_contributors_lacking_relationship
  end
end
