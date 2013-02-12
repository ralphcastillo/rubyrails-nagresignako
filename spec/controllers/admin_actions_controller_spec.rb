require 'spec_helper'

describe AdminActionsController do

  describe "GET 'add_seed'" do
    it "returns http success" do
      get 'add_seed'
      response.should be_success
    end
  end

  describe "GET 'manage_posts'" do
    it "returns http success" do
      get 'manage_posts'
      response.should be_success
    end
  end

  describe "GET 'manage_spam'" do
    it "returns http success" do
      get 'manage_spam'
      response.should be_success
    end
  end

  describe "GET 'facebook_push'" do
    it "returns http success" do
      get 'facebook_push'
      response.should be_success
    end
  end

  describe "GET 'twitter_push'" do
    it "returns http success" do
      get 'twitter_push'
      response.should be_success
    end
  end

end
