require 'spec_helper'

describe User do
  before(:each) do
    @user = User.new(username: "JohnKellyFerguson",
      gravatar_id: "b58b357a352eda178941fd2dfd5c6d5d", email: "hello@johnkellyferguson.com")
  end

  subject { @user }

  it { should respond_to(:username) }
  it { should respond_to(:gravatar_id) }
  it { should respond_to(:email) }
  it { should belong_to(:location) }
  it { should have_many(:contributions) }
  it { should have_many(:repositories).through(:contributions) }

  describe "when username is not present" do
    before { @user.username = "" }
    it { should_not be_valid }
  end

  describe "when username is present" do
    before { @user.username = "username" }
    it { should be_valid }
  end

  describe "when username is already taken" do
    before do
      user_with_same_username = @user.dup
      user_with_same_username.username = @user.username
      user_with_same_username.save
    end

    it { should_not be_valid }
  end

  describe "the delegated method #city" do
    it "returns the correct assocaited city" do
      test_location = Location.create(name: " ")
      test_city = City.create(name: "Test City")
      test_location.city = test_city
      @user.location = test_location
      expect(@user.city).to eq(test_city)
    end
  end

  describe "the delegated method #country" do
    it "returns the correct associated city" do
      test_location = Location.create(name: " ")
      test_city = City.create(name: "Test City")
      test_country = Country.create(name: "Test Country")
      test_city.country = test_country
      test_location.city = test_city
      @user.location = test_location
      expect(@user.country).to eq(test_country)
    end
  end

  describe "#city_name delegation" do
    it "should return the name of the associated City object" do
      test_location = Location.create(name: " ")
      test_city = City.create(name: "Test City")
      test_location.city = test_city
      @user.location = test_location
      expect(@user.city_name).to eq(test_city.name)
    end
  end

  describe "#country_name delegation" do
    it "should return the name of the associated City object" do
      test_location = Location.create(name: " ")
      test_city = City.create(name: "Test City")
      test_country = Country.create(name: "Test Country")
      test_city.country = test_country
      test_location.city = test_city
      @user.location = test_location
      expect(@user.country_name).to eq(test_country.name)
    end
  end

  describe "#has_no_location?" do
    it "returns true if the user has no location" do
      expect(@user.has_no_location?).to eq(true)
    end

    it "returns false if the use has a location" do
      @user.location = Location.new
      expect(@user.has_no_location?).to eq(false)
    end
  end

  describe "#has_no_city?" do
    it "returns true if the user has no locaton" do
      expect(@user.has_no_city?).to eq(true)
    end

    it "returns true if the user has a location but has no associated city" do
      # A blank location is created to avoid the geocode_location after_create callback.
      @user.location = Location.create(name: " ")
      expect(@user.has_no_city?).to eq(true)
    end

    it "returns false if the user has a location and an associated city" do
      @user.location = Location.create(name: "New York")
      expect(@user.has_no_city?).to eq(false)
    end
  end

  describe "#has_no_country?" do
    it "returns true if the user has no location" do
      expect(@user.has_no_country?).to eq(true)
    end

    it "returns true if the user has a location but has no associated city" do
      @user.location = Location.create(name: " ")
      expect(@user.has_no_country?).to eq(true)
    end

    it "returns true if the user has a location but has no associated country" do
      blank_location = Location.create(name: " ")
      blank_location.city = City.create(name: "Test City")
      @user.location = blank_location
      expect(@user.has_no_country?).to eq(true)
    end

    it "returns false if the user has a location and has an associated country" do
      # There is an after_create callback on the Location model that geocodes locations.
      # This will create the associated city and country objects when given a valid location name.
      @user.location = Location.create(name: "New York, NY")
      expect(@user.has_no_country?).to eq(false)
    end
  end

end
