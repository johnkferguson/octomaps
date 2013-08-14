class Repository < ActiveRecord::Base

  # Associations
  has_many :contributions
  has_many :users, through: :contributions

  # Validations
  validates :full_name, presence: true, uniqueness: true
end
