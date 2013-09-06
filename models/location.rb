class Location < ActiveRecord::Base

  # Associations
  belongs_to :city
  has_many :users

  # Validations
  validates :name, presence: true, uniqueness: true

  # Callbacks
  before_create :geocode_location
  before_save { |location| location.name.downcase! }

  def geocode_location
    GeocoderService.new(self).geocode_location
  end

end
