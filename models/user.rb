class User < ActiveRecord::Base

  # Validations
  validates :username, presence: true, uniqueness: true
end
