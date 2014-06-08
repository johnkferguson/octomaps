require 'spec_helper'

class BlankClass
  include GithubConnection
end

describe GithubConnection do
  let(:connection) { BlankClass.new }

  describe "#client" do
    it "is an instance of Octokit::Client" do
      expect(connection.client.class).to eq(Octokit::Client)
    end
  end

  describe "#rate_limit_remaining" do
    it "returns a fixnum" do
      expect(connection.rate_limit_remaining.class).to eq(Fixnum)
    end
  end

end
