class GithubUserService < GithubService
  attr_reader :attributes, :db_user, :username, :gravatar_id, :email, :location

  def initialize(username)
    super()
    @attributes = client.user(username)
    @username = attributes["login"]
    @gravatar_id = attributes["gravatar_id"]
    @email = attributes["email"]
    @location = attributes["location"].downcase
    @db_user = create_user
  end

  private 
    
    def create_user
      User.create!(
        username: username,
        gravatar_id: gravatar_id,
        email: email,
        location: Location.find_or_create_by_name(location)
        )
    end

end