module Github
  class Contributor < RepositoryMember
    def contributions
      attributes.fetch(:contributions)
    end
  end
end
