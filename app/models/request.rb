class Request < ActiveRecord::Base
  self.per_page = 8
  before_destroy :clear_associations
  attr_accessible :date, :description, :end_time, :start_time, :user_id, :priority
  
  belongs_to :user
  belongs_to :volunteer, :class_name => "User", :foreign_key => "volunteer_id"

  has_and_belongs_to_many :circle
  
  validates_presence_of :user_id
  validates_presence_of :date
  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :priority
  validates_numericality_of :priority
  validates :priority, :inclusion => 0..10
  
  def self.delete_old
    Request.where("date < ?", Date.yesterday).destroy_all
  end

  private
    def clear_associations
      self.circle.clear
    end
end
