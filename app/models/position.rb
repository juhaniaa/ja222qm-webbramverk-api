class Position < ActiveRecord::Base
  acts_as_mappable :default_units => :kms
  belongs_to :event  
end
