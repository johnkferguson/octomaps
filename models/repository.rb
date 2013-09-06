class Repository < ActiveRecord::Base

  # Associations
  has_many :contributions, autosave: true, dependent: :destroy
  has_many :users, through: :contributions

  # Validations
  validates :full_name, presence: true, uniqueness: true


  # Instance Methods
  def hash_of_cities_and_count
    users.each_with_object(Hash.new(0)) do |user, hash|
      if user.has_no_location?
        hash["Location Unknown"] += 1
      else
        hash[user.city_name] +=1
      end
    end
  end

  def hash_of_countries_and_count
    users.each_with_object(Hash.new(0)) do |user, hash|
      if user.has_no_location? || user.has_no_country?
        hash["Location Unknown"] += 1
      else
        hash[user.country_name] +=1
      end
    end
  end

end
