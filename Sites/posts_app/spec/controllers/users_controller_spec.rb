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

    it "should have the right title" do
      get :show, :id => @user
      response.should have_selector('title', :content => @user.name)
    end

    it "should have the user's name" do
      get :show, :id => @user
      response.should have_selector('h1', :content => @user.name)
    end

    it "should have a profile image" do
      get :show, :id => @user
      response.should have_selector('h1>img', :class => "gravatar")
    end

    it "should have the right URL" do
      get :show, :id => @user
      response.should have_selector('td>a', :content => user_path(@user), :href => user_path(@user))
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

  describe "POST 'create'" do

    describe "failure" do
      before:each do
        @invalid_user_hash = { :name => "", :email => "", :password => "", :password_confirmation => "" }
      end

      it "should have a right title" do
        post :create, :user => @invalid_user_hash
        response.should have_selector("title", :content => "Sign up")
      end

      it "should render the 'new' page" do
        post :create, :user => @invalid_user_hash
        response.should render_template("new")
      end

      it "should not create a user" do
        lambda do
          post :create, :user => @invalid_user_hash
        end.should_not change(User, :count)
      end

    end
  end
end
