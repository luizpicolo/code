require "rails_helper"

RSpec.describe SchoolPerformacesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/school_performaces").to route_to("school_performaces#index")
    end

    it "routes to #new" do
      expect(:get => "/school_performaces/new").to route_to("school_performaces#new")
    end

    it "routes to #show" do
      expect(:get => "/school_performaces/1").to route_to("school_performaces#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/school_performaces/1/edit").to route_to("school_performaces#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/school_performaces").to route_to("school_performaces#create")
    end

    it "routes to #update" do
      expect(:put => "/school_performaces/1").to route_to("school_performaces#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/school_performaces/1").to route_to("school_performaces#destroy", :id => "1")
    end

  end
end
