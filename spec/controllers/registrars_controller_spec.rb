require 'spec_helper'

describe RegistrarsController do
  describe "GET index" do
    it "should correctly assign the number of patients registered today" do
      Registration.stub(:for_day => [double("Registration")])
      get :index
      assigns(:num_today).should == 1
    end
  end
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
