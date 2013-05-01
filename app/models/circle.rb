class Circle < ActiveRecord::Base
  attr_accessible :description, :name, :user_id
  
  validates_presence_of :description
  validates_presence_of :name
  validates_presence_of :user_id
  
  has_and_belongs_to_many :request
  has_and_belongs_to_many :user
  belongs_to :user
end
