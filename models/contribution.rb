class Contribution < ActiveRecord::Base

  # Associations
  belongs_to :user
  belongs_to :repository

  # Callbacks
  after_create :increment_contributions_count
  after_destroy :decrement_contributions_count


  private

    def increment_contributions_count
      Repository.increment_counter(:contributions_count, self.repository.id)
    end

    def decrement_contributions_count
      Repository.decrement_counter(:contributions_count, self.repository.id)
    end

end
