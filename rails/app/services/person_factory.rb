class PersonFactory
  def initialize(github_user)
    @github_user = github_user
  end

  def perform
    Person.create!(
      github_username: login,
      github_id: id,
      name: name,
      email: email,
      avatar_url: avatar_url,
      gravatar_id: gravatar_id,
      company: company,
      blog: blog,
      hireable: hireable,
      bio: bio,
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

  delegate  :login,
            :id,
            :name,
            :email,
            :avatar_url,
            :gravatar_id,
            :company,
            :blog,
            :hireable,
            :bio,
            :public_repos,
            :public_gists,
            :followers,
            :following,
            :created_at,
            :updated_at,
            to: :github_user
end
