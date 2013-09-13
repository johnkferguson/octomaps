require 'spec_helper'

class BlankClass
  include GithubConnection
end

describe GithubConnection do
  before(:each) do
    @connetion = BlankClass.new
  end

  subject { @connetion }

  it { should respond_to(:client) }

  describe "#client" do
    it "is an instance of Octokit::Client" do
      expect(@connetion.client.class).to eq(Octokit::Client)
    end
  end

  describe "#rate_limit_remaining" do
    it "returns a fixnum" do
      expect(@connetion.rate_limit_remaining.class).to eq(Fixnum)
    end
  end
 
end
