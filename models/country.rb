class Country < ActiveRecord::Base

  # Associations
  has_many :cities

  # Validations
  validates :name, presence: true, uniqueness: true
end
