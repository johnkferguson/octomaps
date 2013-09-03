class Location < ActiveRecord::Base

  # Associations
  belongs_to :geocoded_city
  has_many :users

  # Validations
  validates :name, presence: true, uniqueness: true

  # Callbacks
  after_create :geocode_location

  def geocode_location
    GeocoderService.new(self).geocode_location
  end

end
