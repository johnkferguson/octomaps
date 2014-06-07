module Github
  class Repository < Connection
    attr_reader :full_repo_name

    def initialize(full_repo_name)
      @full_repo_name = full_repo_name
    end

    def attributes
      @attributes ||= client.repo(full_repo_name).to_h rescue {}
    end

    [
      :full_name,
      :id,
      :name,
      :description,
      :homepage,
      :size,
      :fork,
      :forks_count,
      :stargazers_count,
      :watchers_count,
      :subscribers_count,
      :created_at,
      :updated_at,
      :pushed_at
    ].each do |key|
      define_method(key) { attributes.fetch(key) }
    end
  end
end
