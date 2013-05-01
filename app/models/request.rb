class Request < ActiveRecord::Base
  attr_accessible :date, :description, :end_time, :start_time, :user_id
  
  belongs_to :user
  has_and_belongs_to_many :circle
  
  validates_presence_of :user_id
end
