require 'spec_helper'

describe Request do
  
  fixtures :requests
  
  context 'Request Validation' do
    it 'should always have a user id' do
      r = requests(:nouser)
      r.valid?.should be false
      expect(r.errors[:user_id].any?).to eq(true)
    end
    
    it 'should always have a date' do
      r = requests(:nodate)
      r.valid?.should be false
      expect(r.errors[:date].any?).to eq(true)
    end
    
    it 'should always have a start time' do
      r = requests(:nostart)
      r.valid?.should be false
      expect(r.errors[:start_time].any?).to eq(true)
    end
    
    it 'should always have an end time' do
      r = requests(:noend)
      r.valid?.should be false
      expect(r.errors[:end_time].any?).to eq(true)
    end
    
    it 'should always have a priority' do
      r = requests(:nopriority)
      r.valid?.should be false
      expect(r.errors[:priority].any?).to eq(true)
    end
    
    it 'should always have a numeric priority' do
      r = requests(:nopriority)
      r.priority = 'badger'
      r.valid?.should be false
      expect(r.errors[:priority].any?).to eq(true)
    end
    
    it 'should always have a numeric priority in the range 0 to 10' do
      r = requests(:nopriority)
      r.priority = -1
      r.valid?.should be false
      expect(r.errors[:priority].any?).to eq(true)
      
      r.priority = 11
      r.valid?.should be false
      expect(r.errors[:priority].any?).to eq(true)
    end
    
  end
end
