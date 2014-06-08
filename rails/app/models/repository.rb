class Repository
  include Neo4j::ActiveNode

  property :created_at
  property :updated_at
  property :full_name, type: String
  property :github_id, type: Integer
  property :name, type: String
  property :description, type: String
  property :homepage, type: String
  property :size, type: Integer
  property :forked, type: Boolean
  property :github_forks_count, type: Integer
  property :github_stargazers_count, type: Integer
  property :github_watchers_count, type: Integer
  property :github_subscribers_count, type: Integer
  property :github_created_at, type: DateTime
  property :github_updated_at, type: DateTime
  property :github_pushed_at, type: DateTime

  index :github_id
  index :full_name

  validates :github_id, :full_name, presence: true
  validates_uniqueness_of :github_id, :full_name

  has_n(:contributors).from(Person, :contributed_to)
  # has_one(:creator).from(Person, :created_repository)

  def needs_update?(github_updated_datetime:)
    !persisted? || out_of_sync_with_github?(github_updated_datetime)
  end

  private

  def out_of_sync_with_github?(github_updated_datetime)
    github_updated_at != github_updated_datetime
  end
end
