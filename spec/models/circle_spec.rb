require 'spec_helper'

describe Circle do
  
  fixtures :circles
  fixtures :users
  fixtures :requests
  
  context 'Circle Validation' do
    it 'should always have a name' do
      c = circles(:noname)
      c.valid?.should be false
      expect(c.errors[:name].any?).to eq(true)
    end

    it 'should not require a description' do
      c = circles(:nodesc)
      c.valid?.should be true
    end

    it 'should have an owner user' do
      c = circles(:noowner)
      c.valid?.should be false
      expect(c.errors[:owner_id].any?).to eq(true)
    end
  end
  
  context 'Destroy Circle' do
    
    it 'should not destroy associated users' do
      user_count = User.all.count
      u = users(:user1)
      c = circles(:valid)
      c.user << u
      c.destroy
      expect(User.all.count).to eq(user_count)
    end
    
    it 'should not destroy associated requests' do
      r_count = Request.all.count
      r = requests(:valid)
      c = circles(:valid)
      c.request << r
      c.destroy
      expect(Request.all.count).to eq(r_count)
    end
    
  end
end
