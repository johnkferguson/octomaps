require 'spec_helper'

describe Location do
  before(:each) do
    @location = Location.new(name: "New York, NY")
  end

  subject { @location }

  it { should respond_to(:name) }
  it { should belong_to(:city) }
  it { should have_many(:users) }

  describe "when name is not present" do
    before { @location.name = ""}
    it { should_not be_valid }
  end

  describe "when name is present" do
    before { @location.name = "test" }
    it { should be_valid }
  end

  describe "when name is already taken" do
    before do
      location_with_same_name = @location.dup
      location_with_same_name.name = @location.name
      location_with_same_name.save
    end
    it { should_not be_valid }
  end

  describe "when the name is entered with capital letters" do
    before do
      @location.save
    end
    it "should save as lowercase" do
      expect(@location.name).to eq("new york, ny")
    end
  end

end
