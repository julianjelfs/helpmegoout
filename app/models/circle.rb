class Circle < ActiveRecord::Base
  self.per_page = 8
  before_destroy :clear_associations
  attr_accessible :description, :name, :owner_id
  
  validates_presence_of :name
  validates_presence_of :owner_id
  
  has_and_belongs_to_many :request
  has_and_belongs_to_many :user
  has_and_belongs_to_many :candidate
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"


  def list_members
    list = ""
    user.map {|u| u.email}.each { |u| list += "<div>#{u}</div>"}
    return list
  end
  
  
  private
    def clear_associations
      self.user.clear
      self.request.clear
      self.candidate.clear
    end


end
