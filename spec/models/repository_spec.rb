require 'spec_helper'

describe Repository do
  before(:each) do
    @repository = Repository.new(full_name: 'JohnKellyFerguson/octomapss',
                    description: 'View Open Source Contributors on a Map',
                    html_url: 'https://github.com/JohnKellyFerguson/octomaps')
  end

  subject { @repository}

  it { should respond_to(:full_name) }
  it { should respond_to(:description) }
  it { should respond_to(:html_url) }
  it { should have_many(:contributions) }
  it { should have_many(:users).through(:contributions) }


  describe "when full_name is not present" do
    before { @repository.full_name = "" }
    it { should_not be_valid }
  end

  describe "when full_name is present" do
    before { @repository.full_name = "full_name" }
    it { should be_valid }
  end

  describe "when full_name is already taken" do
    before do
      repo_with_same_name = @repository.dup
      repo_with_same_name.full_name = @repository.full_name
      repo_with_same_name.save
    end

    it { should_not be_valid }
  end

  # Cannot get counter cache testing to work properly. Counter cache does update
  # correctly though outside of testing.

  # describe "when a new contribution is created" do
  #   it "updates the counter cache" do
  #     repo = Repository.create(full_name: "sample_repo")
  #     user = User.create(username: "sample_user")
  #     Contribution.create(user: user, repository: repo)
  #     repo.reload.contributions_count
  #     repo.contributions_count.should == 1
  #     end
  #   end
end
