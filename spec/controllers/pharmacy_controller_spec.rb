require 'spec_helper'

describe PharmacyController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "assigns @drugs" do
      drug = Drug.create
      get :index
      assigns(:drugs).should eq([drug])
    end

    it "renders the index template" do
      get :index
      response.should render_template("index")
    end
  end

end
