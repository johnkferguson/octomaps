class GeocodedCountry < ActiveRecord::Base

  # Associations
  has_many :geocoded_cities

  # Validations
  validates :name, presence: true, uniqueness: true
end
