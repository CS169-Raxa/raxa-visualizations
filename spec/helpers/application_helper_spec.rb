require 'spec_helper'

describe ApplicationHelper do
  it 'should produce timestamps in UNIX time when jsoniffied' do
    Time.new(2012, 10, 28, 10, 26, 40, "+00:00").in_time_zone.as_json.should == 1351420000
  end
end
