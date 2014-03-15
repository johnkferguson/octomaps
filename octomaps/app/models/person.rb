class Person
    include Neo4j::ActiveNode
    property :name, :type => String

    property :email, :type => String

    property :username, :type => String

    has_n(:contributed_to).to(Repository)
end
