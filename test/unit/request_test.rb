require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  test "request must have a user id" do
     assert !Request.new.valid?
     assert Request.new({:user_id => 1}).valid?
  end
end
