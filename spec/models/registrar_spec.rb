require 'spec_helper'

describe Registrar do
  it 'must have a name' do
    r = Registrar.new
    r.valid?.should be_false
    r.name = 'Sesh'
    r.valid?.should be_true
  end
end
