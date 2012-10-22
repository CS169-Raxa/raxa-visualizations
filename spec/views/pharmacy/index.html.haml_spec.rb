require 'spec_helper'

describe "pharmacy/index.html.haml" do
  it "displays all the drugs" do
    assign(:drugs, [stub_model(Drug, :name => "amoxicillin"),
                    stub_model(Drug, :name => "vicodin")])
    render
    rendered.should =~ /amoxicillin/
    rendered.should =~ /vicodin/
  end
end
