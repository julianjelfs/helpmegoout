class Circle < ActiveRecord::Base
  before_destroy :clear_associations
  attr_accessible :description, :name, :owner_id
  
  validates_presence_of :name
  validates_presence_of :owner_id
  
  has_and_belongs_to_many :request
  has_and_belongs_to_many :user
  has_and_belongs_to_many :candidate
  belongs_to :owner


  private
    def clear_associations
      self.user.clear
      self.request.clear
      self.candidate.clear
    end


end
