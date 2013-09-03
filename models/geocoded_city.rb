class GeocodedCity < ActiveRecord::Base

  # Associations
  belongs_to :geocoded_country
  has_many :locations

  # Validations
  validates :name, presence: true, uniqueness: true
end
