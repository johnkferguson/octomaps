class Repository
  include Neo4j::ActiveNode

  property :created_at
  property :updated_at
  property :etag, type: String
  property :owner, type: String
  property :name, type: String
  property :full_name, type: String
  property :description, type: String
  property :forks_count, type: Integer
  property :stargazers_count, type: Integer
  property :watchers_count, type: Integer
  property :forked, type: Boolean

  has_n(:contributors).from(Person, :contributed_to)
end

# repo2.contributors.create(joe, commits: 11)
# joe.rels.each { |rel| puts rel.props[:commits] }