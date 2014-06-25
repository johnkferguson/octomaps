class Person
  include Neo4j::ActiveNode

  property :created_at
  property :updated_at
  property :github_username, type: String
  property :github_id, type: Integer
  property :name, type: String
  property :email, type: String
  property :github_location, type: String
  property :avatar_url, type: String
  property :gravatar_id, type: String
  property :company, type: String
  property :blog, type: String
  property :hireable, type: Boolean
  property :github_public_repos_count, type: Integer
  property :github_public_gists_count, type: Integer
  property :github_followers_count, type: Integer
  property :github_following_count, type: Integer
  property :github_created_at, type: DateTime
  property :github_updated_at, type: DateTime

  index :github_id
  index :github_username

  validates :github_id, :github_username, presence: true
  validates :github_id, :github_username, uniqueness: true

  has_n(:contributed_to).to(Repository)

  def self.persisted_usernames_from(usernames_array:)
    Neo4j::Session.query("
    MATCH (persons:Person)
    WHERE persons.github_username IN #{usernames_array}
    RETURN persons.github_username;
    ").to_a.flat_map(&:values)
  end
end
