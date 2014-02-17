require 'spec_helper'

describe Repository do

  it { should respond_to(:full_name) }
  it { should respond_to(:description) }
  it { should respond_to(:html_url) }
  it { should have_many(:contributions) }
  it { should have_many(:users).through(:contributions) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:full_name) }

  describe "#find_by_case_insensitve_name" do
    before(:all) { @repo = Repository.create(full_name: "Octokit/Octokit.rb") }

    context "when given a case insensitive match" do
      it "returns the correct repository" do
        expect(Repository.find_by_case_insensitve_name(@repo.full_name.downcase))
          .to eq(@repo)
      end
    end

    context "when given a case sensitive match" do
      it "should return the correct repository given a case sensitive match" do
        expect(Repository.find_by_case_insensitve_name(@repo.full_name)).to eq(@repo)
      end
    end

  end

end
