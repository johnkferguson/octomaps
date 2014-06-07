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
  property :github_forks_count, type: Integer #github_forks_count
  property :github_stargazers_count, type: Integer # stargazers_count
  property :github_watchers_count, type: Integer # watchers_count
  property :github_subscribers_count, type: Integer # subscribers_count
  property :github_created_at, type: DateTime
  property :github_updated_at, type: DateTime
  property :github_pushed_at, type: DateTime

  has_n(:contributors).from(Person, :contributed_to)
  # has_one(:creator).from(Person, :created_repository)
end

# repo2.contributors.create(joe, commits: 11)
# joe.rels.each { |rel| puts rel.props[:commits] }