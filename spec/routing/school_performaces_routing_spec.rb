################################################################################
# The MIT License (MIT)
#
# Copyright (c) 2016 C.O.D.E
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
################################################################################

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
