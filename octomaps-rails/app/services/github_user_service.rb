class GithubUserService < GithubConnection
  attr_reader :username

  def initialize(username)
    @username = username
  end

  def create_person
    Person.create!(
      github_username: username,
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

  def attributes
    @attributes ||= client.user(username).to_h
  end

  [
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
    :updated_at
  ].each do |key|
    define_method(key) { attributes.fetch(key) }
  end
end
