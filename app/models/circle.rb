class Circle < ActiveRecord::Base
  attr_accessible :description, :name, :user_id
  has_and_belongs_to_many :request
end
