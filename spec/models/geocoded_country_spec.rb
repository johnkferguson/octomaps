require 'spec_helper'

describe GeocodedCountry do
  before(:each) do
    @country = GeocodedCountry.new(name: "United States")
  end

  subject { @country }

  it { should respond_to(:name) }
  it { should have_many(:geocoded_cities) }

  describe "when name is not present" do
    before { @country.name = ""}
    it { should_not be_valid }
  end

  describe "when name is present" do
    before { @country.name = "test" }
    it { should be_valid }
  end

  describe "when name is already taken" do
    before do
      country_with_same_name = @country.dup
      country_with_same_name.name = @country.name
      country_with_same_name.save
    end
    it { should_not be_valid }
  end

end
