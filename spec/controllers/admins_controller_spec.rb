require 'spec_helper'

describe AdminsController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'add'" do
    it "returns http success" do
      get 'add'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit'
      response.should be_success
    end
  end

  describe "GET 'change_password'" do
    it "returns http success" do
      get 'change_password'
      response.should be_success
    end
  end

  describe "GET 'manage_posts'" do
    it "returns http success" do
      get 'manage_posts'
      response.should be_success
    end
  end

  describe "GET 'spam'" do
    it "returns http success" do
      get 'spam'
      response.should be_success
    end
  end

end
