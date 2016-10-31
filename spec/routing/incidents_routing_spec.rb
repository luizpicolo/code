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

RSpec.describe IncidentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/incidents").to route_to("incidents#index")
    end

    it "routes to #new" do
      expect(:get => "/incidents/new").to route_to("incidents#new")
    end

    it "routes to #show" do
      expect(:get => "/incidents/1").to route_to("incidents#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/incidents/1/edit").to route_to("incidents#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/incidents").to route_to("incidents#create")
    end

    it "routes to #update" do
      expect(:put => "/incidents/1").to route_to("incidents#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/incidents/1").to route_to("incidents#destroy", :id => "1")
    end

  end
end
