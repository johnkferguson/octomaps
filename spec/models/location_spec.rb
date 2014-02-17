require 'spec_helper'

describe Location do
  let(:location) { Location.new(name: "New York, NY") }

  it { should respond_to(:name) }
  it { should belong_to(:city) }
  it { should have_many(:users) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  describe "when the name is entered with capital letters" do
    before do
      Location.any_instance.stub(:geocode_location).and_return(nil)
      location.save
    end
    it "should save as lowercase" do
      expect(location.name).to eq("new york, ny")
    end
  end

end
