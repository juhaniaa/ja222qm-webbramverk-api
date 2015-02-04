class Event < ActiveRecord::Base
  has_one :position, dependent: :destroy
  has_and_belongs_to_many :tags
  belongs_to :hunter
end
