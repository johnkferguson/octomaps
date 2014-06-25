module Github
  class User < APIConnection
    attr_reader :username

    def initialize(username)
      @username = username
    end

    def attributes
      @attributes ||= client.user(username)
    rescue Octokit::NotFound
      not_found
    end

    def not_found?
      attributes == not_found
    end

    delegate :login, :id, :name, :email, :location, :avatar_url, :gravatar_id,
             :company, :blog, :hireable, :public_repos, :public_gists,
             :followers, :following, :created_at, :updated_at,
             to: :attributes
  end
end
