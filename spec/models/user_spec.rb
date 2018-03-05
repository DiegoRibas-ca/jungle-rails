require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Validations" do

    it "user with all four fields will save successfully" do
      @user = User.new(first_name: "diego",
        last_name: "Ribas",
        email: "diego3@diego.com",
        password: "212122",
        password_confirmation: "212122")

      expect(@user.first_name).to eq("diego")
      expect(@user.last_name).to eq("Ribas")
      expect(@user.email).to eq("diego3@diego.com")
      expect(@user.password).to eq("212122")
      expect(@user.password_confirmation).to eq("212122")
      expect(@user.errors.full_messages.size).to eq(0)
    end

    it "password confirmation should be the same as password" do
      @user = User.new(first_name: "diego",
        last_name: "Ribas",
        email: "diego3@diego.com",
        password: "2121222",
        password_confirmation: "2121332")

      expect(@user).to_not be_valid
      expect(@user.errors[:password_confirmation].size).to eq(2)
    end
    it "password length should be more than 5" do
      @user = User.new(first_name: "diego",
        last_name: "Ribas",
        email: "diego3@diego.com",
        password: "2121",
        password_confirmation: "2121")

      expect(@user).to_not be_valid
      expect(@user.errors[:password].size).to eq(1)
    end
    it "same email even case sensitive shouldnt be created" do
      @user1 = User.create!(first_name: "same",
        last_name: "email",
        email: "test@test.com",
        password: "1234567",
        password_confirmation: "1234567")
      @user2 = User.new(first_name: "same",
        last_name: "email",
        email: "TEST@test.com",
        password: "1234567",
        password_confirmation: "1234567")

      expect(@user2).to_not be_valid
      expect(@user2.errors[:email].size).to eq(1)
    end

    it "first_name should be required" do
      @user = User.new(first_name: nil,
        last_name: "Ribas",
        email: "diego3@diego.com",
        password: "2121222",
        password_confirmation: "2121222")

      expect(@user).to_not be_valid
      expect(@user.errors[:first_name].size).to eq(1)
    end
    it "last name should be required" do
      @user = User.new(first_name: "diego",
        last_name: nil,
        email: "diego3@diego.com",
        password: "2121222",
        password_confirmation: "2121222")

      expect(@user).to_not be_valid
      expect(@user.errors[:last_name].size).to eq(1)
    end
    it "email should be required" do
      @user = User.new(first_name: nil,
        last_name: "Ribas",
        email: nil,
        password: "2121222",
        password_confirmation: "2121222")

      expect(@user).to_not be_valid
      expect(@user.errors[:email].size).to eq(2)
    end
    # it { is_expected.to validate_presence_of(:name) }
    # it { is_expected.to validate_presence_of(:price) }
    # it { is_expected.to validate_presence_of(:quantity) }
    # it { is_expected.to validate_presence_of(:category) }
  end

  describe ".authenticate_with_credentials" do

    it "given a email and password, authenticate them and login" do
      @user = User.create!(first_name: "diego",
        last_name: "Ribas",
        email: "email1@email.com",
        password: "2121222",
        password_confirmation: "2121222")

      expect(@user.authenticate_with_credentials(@user.email, @user.password)).to be_valid
      expect(@user.authenticate_with_credentials(@user.email, 'wrongPassowrd')).to eq(nil)
    end 
    it "spaces before and after an email should be accepted" do
      @user = User.create!(first_name: "diego",
        last_name: "Ribas",
        email: "email1@email.com",
        password: "2121222",
        password_confirmation: "2121222")

      expect(@user.authenticate_with_credentials("     email1@email.com", @user.password)).to be_valid
    end 
    it "case sensitive email should be accepted" do
      @user = User.create!(first_name: "diego",
        last_name: "Ribas",
        email: "email1@email.com",
        password: "2121222",
        password_confirmation: "2121222")

      expect(@user.authenticate_with_credentials("eMail1@eMail.cOm", @user.password)).to be_valid
    end 

  end



end
