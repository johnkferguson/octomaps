require 'spec_helper'

describe GithubService do
  before(:each) do
    @github = GithubService.new
  end

  subject { @github }

  it { should respond_to(:client) }

  describe "#client" do
    it "is an instance of Octokit::Client" do
      expect(@github.client.class).to eq(Octokit::Client)
    end
  end

  describe "#rate_limit_remaining" do
    it "returns a fixnum" do
      expect(@github.rate_limit_remaining.class).to eq(Fixnum)
    end
  end
 
end