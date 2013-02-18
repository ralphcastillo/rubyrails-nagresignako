require 'spec_helper'

describe FbOauthController do

  describe "GET 'start'" do
    it "returns http success" do
      get 'start'
      response.should be_success
    end
  end

  describe "GET 'callback'" do
    it "returns http success" do
      get 'callback'
      response.should be_success
    end
  end

end
