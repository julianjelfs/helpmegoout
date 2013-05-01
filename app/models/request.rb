class Request < ActiveRecord::Base
  attr_accessible :date, :end_time, :start_time, :user_id
  
  belongs_to :user
  has_and_belongs_to_many :circle
end
