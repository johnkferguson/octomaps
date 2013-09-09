class User < ActiveRecord::Base

  # Associations
  belongs_to :location
  has_many :contributions, dependent: :destroy
  has_many :repositories, through: :contributions

  # Validations
  validates :username, presence: true, uniqueness: true

  # Delegations
  delegate :city, to: :location
  delegate :name, to: :city, prefix: true
  delegate :country, to: :city
  delegate :name, to: :country, prefix: true

  # Instance methods
  def has_no_location?
    location == nil
  end

  def has_no_city?
    has_no_location? || city == nil
  end

  def has_no_country?
    has_no_city? || country == nil
  end

end
