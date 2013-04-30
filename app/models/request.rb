class Request < ActiveRecord::Base
  attr_accessible :date, :end_time, :start_time, :user_id
end
