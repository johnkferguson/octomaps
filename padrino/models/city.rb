class City < ActiveRecord::Base

  # Associations
  belongs_to :country
  has_many :locations

  # Validations
  validates :name, presence: true, uniqueness: true
end
