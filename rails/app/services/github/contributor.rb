module Github
  class Contributor < RepositoryMember
    define_method(:contributions) { attributes.fetch(key) }
  end
end
