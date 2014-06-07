class Person
  include Neo4j::ActiveNode

  property :created_at
  property :updated_at
  property :etag, type: String
  property :name, type: String
  property :email, type: String
  property :username, type: Boolean

  has_n(:contributed_to).to(Repository)
end
