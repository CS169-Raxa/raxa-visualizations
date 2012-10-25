require 'spec_helper'

describe Registration do
  it "should have patient_status default to 'new'" do
    r = Registration.new
    r.patient_status.should == 'new'
  end
  it "should only allow 'new' or 'returning' for patient_status" do
    r = Registration.new(:patient_status => 'new')
    r.valid?.should be_true
    r.patient_status = 'returning'
    r.valid?.should be_true
    r.patient_status = 'hullo'
    r.valid?.should be_false
  end
end
