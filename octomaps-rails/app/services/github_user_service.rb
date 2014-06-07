class GithubUserService
  include GithubConnection
  attr_reader :attributes, :username, :name, :email

  def initialize(username)
    @attributes = client.user(username)
    @username = attributes["login"]
    @name = attributes["name"]
    @email = attributes["email"]
  end
end
