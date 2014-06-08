require 'spec_helper'

describe Location do
  before { Location.any_instance.stub(:geocode_location).and_return(nil) }
  let(:location) { Location.new(name: "New York, NY") }

  it { should respond_to(:name) }
  it { should belong_to(:city) }
  it { should have_many(:users) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  describe "when the name is entered with capital letters" do
    it "should save as lowercase" do
      expect { location.save }.to change { location.name }
        .from("New York, NY").to("new york, ny")
    end
  end

end
