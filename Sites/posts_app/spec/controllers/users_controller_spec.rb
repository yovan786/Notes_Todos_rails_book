require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'show'" do
    before:each do
      @user = Factory(:user)
    end

    it "returns http success" do
      get :show, :id => @user.id #we could also use get :show, :id => @user as rails knows that it must pass the id of the @user object.
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end

  end

  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "Sign up")
    end
  end

end
