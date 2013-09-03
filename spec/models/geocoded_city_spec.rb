require 'spec_helper'

describe GeocodedCity do
  before(:each) do
    @city = GeocodedCity.new(name: "New York")
  end

  subject { @city }

  it { should respond_to(:name) }
  it { should have_many(:locations) }
  it { should belong_to(:geocoded_country) }


  describe "when name is not present" do
    before { @city.name = ""}
    it { should_not be_valid }
  end

  describe "when name is present" do
    before { @city.name = "test" }
    it { should be_valid }
  end

  describe "when name is already taken" do
    before do
      city_with_same_name = @city.dup
      city_with_same_name.name = @city.name
      city_with_same_name.save
    end
    it { should_not be_valid }
  end

end
