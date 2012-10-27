require 'spec_helper'

describe Patient do
  it 'must have a name' do
    p = Patient.new
    p.valid?.should be_false
    p.name = 'Dan'
    p.valid?.should be_true
  end
end
