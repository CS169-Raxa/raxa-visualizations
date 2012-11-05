require 'spec_helper'

describe RegistrarsController do
  describe "GET index" do
    it "should assign the number of patients registered today" do
      get :index
      assigns(:num_today).should_not be_nil
    end
  end
  describe "GET show" do
    it "should assign the number of patients registered today" do
      registrar = Registrar.create(:name => 'Jon Ko')
      get :show, :id => registrar.id
      assigns(:num_today).should_not be_nil
    end
  end
end
