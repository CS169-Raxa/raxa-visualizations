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
  describe "scope 'for_day'" do
    it "should only grab Registrations ended in a certain day" do
      bad = Registration.create(:time_end => DateTime.new(2012, 10, 23, 6))
      good = Registration.create(:time_end => DateTime.new(2012, 10, 24, 7))
      Registration.for_day(Date.new(2012, 10, 24)).should == [good]
    end
    it "should ignore the time component of its argument" do
      good = Registration.create(:time_end => DateTime.new(2012, 10, 24, 7))
      Registration.for_day(DateTime.new(2012, 10, 24, 8)).should include(good)
    end
  end
end
