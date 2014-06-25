module Neo4jConnection
  class PersonUpdater
    def initialize(github_username:)
      @github_user = Github::User.new(github_username)
    end

    def perform
      return if github_user.not_found?
      Person.find(conditions: { github_username: login }).update!(
        name: name,
        email: email,
        github_location: location,
        avatar_url: avatar_url,
        gravatar_id: gravatar_id,
        company: company,
        blog: blog,
        hireable: hireable,
        github_public_repos_count: public_repos,
        github_public_gists_count: public_gists,
        github_followers_count: followers,
        github_following_count: following,
        github_created_at: created_at,
        github_updated_at: updated_at
      )
    end

    private

    attr_reader :github_user

    delegate :login, :name, :email, :location, :avatar_url, :gravatar_id,
             :company, :blog, :hireable, :public_repos, :public_gists,
             :followers, :following, :created_at, :updated_at,
             to: :github_user
  end
end
