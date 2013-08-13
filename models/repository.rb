class Repository < ActiveRecord::Base

  # Validations
  validates :full_name, presence: true, uniqueness: true
end
