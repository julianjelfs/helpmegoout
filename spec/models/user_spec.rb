require 'spec_helper'

describe User do
  
  fixtures :users
  fixtures :requests
  fixtures :circles
  
  context 'User destroy' do
    it 'should destroy a users requests when destroying a user' do
      u = users(:user1) 
      u.request << requests(:valid)
      expect(u.request.length).to eq(1)
      req_count = Request.all.count
      u.destroy
      expect(Request.all.count).to eq(req_count - 1)
    end
    
    it "user should be removed from circles when destroyed" do
      u = users(:user1) 
      c = circles(:valid)
      c.user << u
      u.destroy
      expect(c.user.count).to eq(0)
    end
    
  end
  
end
