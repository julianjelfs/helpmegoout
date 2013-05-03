class Candidate < ActiveRecord::Base
  attr_accessible :email
  validates_presence_of :email
  validates_uniqueness_of :email
  has_and_belongs_to_many :circle
end
