class GithubRepositoryService < GithubService
  attr_reader :db_repo, :repo_name

  def initialize(repo_name)
    super()
    @repo_name = repo_name
    @db_repo = Repository.find_by_case_insensitve_name(repo_name) || create_repository
  end

  def github_repository
    @github_repository ||= client.repo(repo_name) rescue nil
  end

  def update_database_based_upon_github
    associate_or_create_contributors if missing_contributors?  
  end

  private

    def associate_or_create_contributors
      contributor_usernames_not_associated_with_repository.each do |contrib_name|
        user = User.find_by_username(contrib_name) || GithubUserService.new(contrib_name).db_user
        Contribution.create(user: user, repository: db_repo)          
      end
    end

    def create_repository
      Repository.create(
        full_name: github_repository["full_name"],
        description: github_repository["description"],
        html_url: github_repository["homepage"]
        )
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

    def github_contributors
      @github_contributors ||= client.contribs(repo_name) rescue nil
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