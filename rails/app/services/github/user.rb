module Github
  class User < APIConnection
    attr_reader :username

    def initialize(username)
      @username = username
    end

    def attributes
      @attributes ||= client.user(username).to_h
    end

    [
      :login,
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
end
