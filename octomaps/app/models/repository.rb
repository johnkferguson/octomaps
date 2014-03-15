class Repository
    include Neo4j::ActiveNode
    property :owner, type: String
    property :name, type: String
    property :full_name, type: String
    property :description, type: String
    property :forks_count, type: Integer
    property :stargazers_count, type: Integer
    property :watchers_count, type: Integer
    property :forked, type: String # Boolean stored as string
    # has_n :people
    # has_n(:contributions).from(:repositories)
    has_n(:contributors).from(Person, :contributed_to)
end

# repo2.contributors.create(joe, commits: 11)
# joe.rels.each { |rel| puts rel.props[:commits] }