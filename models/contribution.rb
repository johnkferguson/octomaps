class Contribution < ActiveRecord::Base

  # Associations
  belongs_to :user
  belongs_to :repository

end
