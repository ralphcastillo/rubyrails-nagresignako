require 'spec_helper'

describe PostsController do

  describe "GET 'hot'" do
    it "returns http success" do
      get 'hot'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'submit'" do
    it "returns http success" do
      get 'submit'
      response.should be_success
    end
  end

  describe "GET 'vote_up'" do
    it "returns http success" do
      get 'vote_up'
      response.should be_success
    end
  end

  describe "GET 'vote_down'" do
    it "returns http success" do
      get 'vote_down'
      response.should be_success
    end
  end

  describe "GET 'report'" do
    it "returns http success" do
      get 'report'
      response.should be_success
    end
  end

end
