class Hunter < ActiveRecord::Base
  has_secure_password
  has_many :events
  
  validates :name,
    presence: {message: "Name is required"},
    uniqueness: true
end
