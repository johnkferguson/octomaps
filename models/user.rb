class User < ActiveRecord::Base

  # Associations
  belongs_to :location
  has_many :contributions, dependent: :destroy
  has_many :repositories, through: :contributions

  # Validations
  validates :username, presence: true, uniqueness: true

  # Instance methods
  def has_no_location?
    location == nil
  end

  def has_no_country?
    location.city == nil || location.city.country == nil
  end

  def city_name
    location.city.name
  end

  def country_name
    location.city.country.name
  end


end
