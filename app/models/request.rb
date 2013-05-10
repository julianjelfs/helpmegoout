class Request < ActiveRecord::Base
  before_destroy :clear_associations
  attr_accessible :date, :description, :end_time, :start_time, :user_id
  
  belongs_to :user
  belongs_to :volunteer, :class_name => "User", :foreign_key => "volunteer_id"

  has_and_belongs_to_many :circle
  
  validates_presence_of :user_id
  validates_presence_of :date
  validates_presence_of :start_time
  validates_presence_of :end_time

  private
    def clear_associations
      self.circle.clear
    end
end
