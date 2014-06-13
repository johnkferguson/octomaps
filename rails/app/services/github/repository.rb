module Github
  class Repository < APIConnection
    attr_reader :full_repo_name

    def initialize(full_repo_name)
      @full_repo_name = full_repo_name
    end

    def attributes
      @attributes ||= client.repo(full_repo_name) rescue not_found
    end

    def exists?
      attributes != not_found
    end

    delegate  :full_name, :id, :name, :description, :homepage, :size, :fork,
              :forks_count, :stargazers_count, :watchers_count,
              :subscribers_count, :created_at, :updated_at, :pushed_at,
              to: :attributes

    def owner
      @owner ||= attributes.owner
    end

    def contributors
      @contributors ||= client.contribs(full_name) rescue not_found
    end
  end
end
