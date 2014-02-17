require 'spec_helper'

describe User do
  let(:user) do
    User.new(username: "JohnKellyFerguson",
      gravatar_id: "b58b357a352eda178941fd2dfd5c6d5d",
      email: "hello@johnkellyferguson.com")
  end
  let(:city) { City.new(name: "New York") }
  let(:country) { Country.new(name: "United States") }

  it { should respond_to(:username) }
  it { should respond_to(:gravatar_id) }
  it { should respond_to(:email) }
  it { should belong_to(:location) }
  it { should have_many(:contributions) }
  it { should have_many(:repositories).through(:contributions) }
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }

  describe "the delegated method #city" do
    it "returns the correct assocaited city" do
      user.location = Location.new(city: city)
      expect(user.city).to eq(city)
    end
  end

  describe "the delegated method #country" do
    it "returns the correct associated country" do
      user.location = Location.new(city: City.new(country: country))
      expect(user.country).to eq(country)
    end
  end

  describe "#city_name delegation" do
    it "should return the name of the associated City object" do
      user.location = Location.new(city: city)
      expect(user.city_name).to eq(city.name)
    end
  end

  describe "#country_name delegation" do
    it "should return the name of the associated City object" do
      user.location = Location.new(city: City.new(country: country))
      expect(user.country_name).to eq(country.name)
    end
  end

  describe "#has_no_location?" do
    context "when the user has no location" do
      it "returns true" do
        expect(user.has_no_location?).to eq(true)
      end
    end

    context "when the user has a location" do
      before { user.location = Location.new }
      it "returns false if the use has a location" do
        expect(user.has_no_location?).to eq(false)
      end
    end
  end

  describe "#has_no_city?" do
    context "when the user has no location" do
      it "returns true" do
        expect(user.has_no_city?).to eq(true)
      end
    end

    context "when the user has a location but has no associated city" do
      before { user.location = Location.new }
      it "returns true " do
        expect(user.has_no_city?).to eq(true)
      end
    end

    context "when the user has a location and an associated city" do
      before { user.location = Location.new(city: City.new) }
      it "returns false if the user has a location and an associated city" do
        expect(user.has_no_city?).to eq(false)
      end
    end
  end

  describe "#has_no_country?" do
    context "when the user has no country" do
      it "returns true" do
        expect(user.has_no_country?).to eq(true)
      end
    end

    context "when the user has a location but has no associated city" do
      before { user.location = Location.new }
      it "returns true" do
        expect(user.has_no_country?).to eq(true)
      end
    end

    context "when the user has a location but has no associated country" do
      before { user.location = Location.new(city: City.new) }
      it "returns true" do
        expect(user.has_no_country?).to eq(true)
      end
    end

    context "when the user has a location and has an associated country" do
      before { user.location = Location.new(city: City.new(country: Country.new)) }
      it "returns false" do
        expect(user.has_no_country?).to eq(false)
      end
    end
  end

end
