require 'spec_helper'

describe RegistrarsController do
  describe "GET show" do
    it "should correctly assign the number of patients registered today" do
      registrar = Registrar.create(:name => 'a')
      registrations = [double("Registration"), double("Registration")]
      Registrar.any_instance.stub(:registrations_for_day) { registrations }
      get :show, :id => registrar.id
      assigns(:num_today).should == 2
    end
  end
end
