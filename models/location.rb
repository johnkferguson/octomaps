class Location < ActiveRecord::Base

  # Associations
  has_many :users

  # Validations
  validates :name, presence: true, uniqueness: true

end
