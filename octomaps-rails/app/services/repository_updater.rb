class RepositoryUpdater
  def initialize(github_repository)
    @github_repository = github_repository
  end

  def perform
    if target_repository.needs_update?(updated_at)
      target_repository.update!(
        name: name,
        description: description,
        homepage: homepage,
        size: size,
        forked: fork,
        github_forks_count: forks_count,
        github_watchers_count: watchers_count,
        github_subscribers_count: subscribers_count,
        github_created_at: created_at,
        github_updated_at: updated_at,
        github_pushed_at: pushed_at
      )
    end
    target_repository
  end

  private

  attr_reader :github_repository

  def target_repository
    @target_repository ||= persisted_repository || new_repository
  end

  def persisted_repository
    Repository.find(conditions: { github_id: id, full_name: full_name })
  end

  def new_repository
    Repository.new(github_id: id, full_name: full_name)
  end

  delegate  :full_name,
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
            :pushed_at,
            to: :github_repository

end
