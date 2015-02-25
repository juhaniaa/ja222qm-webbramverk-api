class User < ActiveRecord::Base
  has_one :apikey, dependent: :destroy
  has_secure_password
        
  validates :password,
		length: { minimum: 5 }
  
  validates :email,
    presence: {message: "E-mail is required"},
    uniqueness: true
  
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    presence: {message: "E-mail not valid"}
end
