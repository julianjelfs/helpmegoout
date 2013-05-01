class Child < ActiveRecord::Base
  attr_accessible :dob, :name
  
  belongs_to :user
  
end
