class Contribution < ActiveRecord::Base

  # Associations
  belongs_to :user
  belongs_to :repository

  # Callbacks
  after_create :increment_contributions_counts
  after_destroy :decrement_contributions_counts


  private

    def increment_contributions_counts
      increment_repository_contributions_count
      increment_users_contributions_count
    end

    def decrement_contributions_counts
      decrement_repository_contributions_count
      decrement_users_contributions_count
    end

    def increment_repository_contributions_count
      Repository.increment_counter(:contributions_count, repository_id)
    end

    def increment_users_contributions_count
      User.increment_counter(:contributions_count, user_id)
    end

    def decrement_repository_contributions_count
      Repository.decrement_counter(:contributions_count, repository_id)
    end
    
    def decrement_users_contributions_count
      User.decrement_counter(:contributions_count, user_id)
    end

end
