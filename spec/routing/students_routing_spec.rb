require "rails_helper"

RSpec.describe StudentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/students").to route_to("students#index")
    end

    it "routes to #new" do
      expect(:get => "/students/new").to route_to("students#new")
    end

    it "routes to #show" do
      expect(:get => "/students/1").to route_to("students#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/students/1/edit").to route_to("students#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/students").to route_to("students#create")
    end

    it "routes to #update" do
      expect(:put => "/students/1").to route_to("students#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/students/1").to route_to("students#destroy", :id => "1")
    end

  end
end
