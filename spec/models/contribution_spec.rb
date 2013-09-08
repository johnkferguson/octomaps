require 'spec_helper'

describe Contribution do
  before(:each) do
    @contribution = Contribution.new(repository_id: 1, user_id: 1)
  end

  subject { @contribution }

  it { should respond_to(:user) }
  it { should respond_to(:repository) }
  it { should belong_to(:user) }
  it { should belong_to(:repository)}

  describe "when a contribution is created" do
    it "increments the contributions_count on the associated User object" do
      user = User.create(username: "test_username", id: 1)      
      @contribution.save
      user.reload.contributions_count
      expect(user.contributions_count).to eq(1)
    end

    it "increments the contributions count on the Repository model" do
      repo = Repository.create(full_name: "test_repo", id: 1)
      @contribution.save
      repo.reload.contributions_count
      expect(repo.contributions_count).to eq(1)
    end
  end

  describe "when a contribution is destroyed" do
    it "decrements the contributions count on the associated User object" do
      user = User.create(username: "test_username", id: 2)
      @contribution.user_id = 2
      @contribution.save
      expect{@contribution.destroy}.to change{user.reload.contributions_count}.from(1).to(0)
    end

    it "decrements the contributions count on the associated Repository object" do
      repo = Repository.create(full_name: "test_repo", id: 2)
      @contribution.repository_id = 2
      @contribution.save
      expect{@contribution.destroy}.to change{repo.reload.contributions_count}.from(1).to(0)
    end
  end

end
