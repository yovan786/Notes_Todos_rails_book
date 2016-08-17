# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do

  before(:each) do
    @user = { :name => "John Doe", :email => "john.doe@gmail.com" }
  end

  it "should create a new instance given a valid attribute" do
    User.create!(@user)
  end

  it "should require a name" do
    no_name_user = User.new(@user.merge(:name => ""))
    no_name_user.should_not be_valid # when we have a be_test, this means that rspec will run the test? method on the the object
  end

  it "should require an email" do
    no_email_user = User.new(@user.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new(@user.merge(:name => long_name))
    long_name_user.should_not be_valid
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com THE_USER_at_foo.bar.org first.last@foo.]
    addresses.each do |address|
    	invalid_email_user = User.new(@user.merge(:email => address))
    	invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    User.create!(@user)
    user_with_duplicate_email = User.new(@user)
    user_with_duplicate_email.should_not be_valid
  end

   it "should reject email addresses identical up to case" do
   	upcased_email = @user[:email].upcase
   	User.create!(@user.merge(:email => upcased_email))
	user_with_duplicate_email = User.new(@user)
    user_with_duplicate_email.should_not be_valid
  end

end
