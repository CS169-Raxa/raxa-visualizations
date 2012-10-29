require 'spec_helper'

describe RegistrationController do

  describe "GET 'index'" do
    it "assigns @registrars" do
      registrar = Registrar.create(:name => 'Sesh')
      get :index
      assigns(:registrars).should eq([registrar])
    end

    it "renders the index template" do
      get :index
      response.should render_template('index')
    end
  end

end
