class Repository < ActiveRecord::Base

  # Associations
  has_many :contributions, autosave: true, dependent: :destroy
  has_many :users, through: :contributions

  # Validations
  validates :full_name, presence: true, uniqueness: true

  # Class Methods
  def self.find_by_case_insensitve_name(name)
    where("full_name ILIKE ?", name).first
  end

end
