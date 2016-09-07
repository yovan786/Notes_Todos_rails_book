# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  encrypted_password :string(255)
#

require 'spec_helper'

describe User do

  before:each do
    @user_hash = { :name => "Sample User",
                   :email => "sample.user@gmail.com",
                   :password => "password",
                   :password_confirmation => "password"
                   }
  end

  it "should create a new instance given a valid attribute" do
    User.create! @user_hash
  end

  it "should require a name attribute" do
    no_name_user = User.new @user_hash.merge :name => ""
    no_name_user.should_not be_valid
  end

  it "should require an email attribute" do
    no_email_user = User.new @user_hash.merge :email => ""
    no_email_user.should_not be_valid
  end

  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new @user_hash.merge :name => long_name
    long_name_user.should_not be_valid
  end

  it "should reject invalid emails" do
    addresses = %w[user@foo,com user_at_gmail.com yovan.juggoo@.com test@gmail]
    addresses.each do |address|
      invalid_email_user = User.new @user_hash.merge :email => address
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    User.create!(@user_hash)
    user_with_duplicate_email = User.new(@user_hash)
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @user_hash[:email].upcase
    User.create!(@user_hash.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@user_hash)
    user_with_duplicate_email.should_not be_valid
  end

  describe "passwords" do
    before:each do
      @user = User.new @user_hash
    end

    it "should have a password attribute" do
      @user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
  end

  describe "password validations" do
    it "should require a password" do
      User.new(@user_hash.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@user_hash.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @user_hash.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it "should reject long passwords" do
      long = "a" * 41
      hash = @user_hash.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end

  describe "password encryption" do
    before:each do
      @user = User.create!(@user_hash)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end

    it "should have a salt" do
      @user.should respond_to(:salt)
    end

    describe "has_password? method" do
      it "should exist" do
        @user.should respond_to(:has_password?)
      end

      it "should return true if the passwords match" do
        @user.has_password?(@user_hash[:password]).should be_truthy
      end

      it "should return false if the passwords don't match" do
        @user.has_password?("invalid").should be_falsy
      end
    end

    describe "authenticate method" do
      it "should exist" do
        User.should respond_to(:authenticate)
      end

      it "should return nil on email/password mismatch" do
        User.authenticate(@user_hash[:email], "WrongPassword").should be_nil
      end

      it "should return nil for an email address with no user" do
        User.authenticate("not_a_user_email@example.net", @user_hash[:password]).should be_nil
      end

      it "should return a user on email/password match" do
        User.authenticate(@user_hash[:email], @user_hash[:password]).should == @user
      end
    end


  end
end
