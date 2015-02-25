class User < ActiveRecord::Base
  has_one :apikey, dependent: :destroy
end
