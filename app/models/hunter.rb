class Hunter < ActiveRecord::Base
  has_many :events
  
  validates :name,
    presence: {message: "Name is required"},
    uniqueness: true
end
