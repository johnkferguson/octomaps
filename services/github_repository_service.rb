class GithubRepositoryService
  attr_reader :db_repo, :repo_name

  @@octokit_client = Octokit::Client.new(:login => "flatiron-001",
                                         :password => "flatiron001")

  def initialize(repo_name)
    @repo_name = repo_name
    @db_repo = Repository.find_by_full_name(repo_name)
  end

  def github_repository
    @github_repository = @@octokit_client.repo(repo_name) rescue nil
  end

  def github_contributors
    @github_contributors = @@octokit_client.contribs(repo_name) rescue nil
  end

  def update_database_based_upon_github
    if github_repository
      create_repository unless repository_in_database?
      associate_or_create_contributors if missing_contributors?
    end
  end

  def associate_or_create_contributors
    contributor_usernames_not_associated_with_repository.each do |contrib_username|
      if user = User.find_by_username(contrib_username)
        Contribution.create(user: user, repository: db_repo)
      else
        db_user = GithubUserService.new(contrib_username).db_user
        Contribution.create(user: db_user, repository: db_repo)
      end
    end
  end

  def create_repository
    @db_repo = Repository.create(
      full_name: github_repository["full_name"],
      description: github_repository["description"],
      html_url: github_repository["homepage"]
      )
  end

  def repository_in_database?
    true if db_repo
  end

  def missing_contributors?
    database_contributors_count < github_contributors_count
  end

  def database_contributors
    db_repo.users.all
  end

  def database_contributors_count
    db_repo.contributions_count
  end

  def database_contributors_usernames
    database_contributors.collect { |c| c.username }
  end

  def github_contributors_count
    github_contributors.size
  end

  def github_contributors_usernames
    github_contributors.collect{ |g| g["login"] }
  end

  def contributor_usernames_not_associated_with_repository
    github_contributors_usernames - database_contributors_usernames
  end

end