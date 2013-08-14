class User < ActiveRecord::Base

  # Associations
  has_many :contributions
  has_many :repositories, through: :contributions

  # Validations
  validates :username, presence: true, uniqueness: true
end
