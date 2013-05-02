require 'spec_helper'

describe Circle do
  context 'Creating a circle' do

    it 'should always have a name' do
      c = Circle.new
      c.valid?.should be false
    end

    it 'should always have a description' do
      c = Circle.new
      c.valid?.should be false
    end

    it 'should have an owner user' do

    end

  end

  context 'Removing a circle' do
    it 'should only be possible for the owner to delete' do

    end
  end
end
