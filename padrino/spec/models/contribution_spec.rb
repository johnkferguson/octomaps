require 'spec_helper'

describe Contribution do
  let(:contribution)  { Contribution.new(repository_id: 1, user_id: 1) }

  it { should respond_to(:user) }
  it { should respond_to(:repository) }
  it { should belong_to(:user) }
  it { should belong_to(:repository) }

  describe "when a contribution is created" do
    after(:each) { contribution.save }
    it "increments the contributions_count on the associated User object" do
      expect(User).to receive(:increment_counter)
        .with(:contributions_count, contribution.user_id)
    end

    it "increments the contributions count on the Repository model" do
      expect(Repository).to receive(:increment_counter)
        .with(:contributions_count, contribution.repository_id)
    end
  end

  describe "when a contribution is destroyed" do
    after(:each) { contribution.destroy }
    it "decrements the contributions count on the associated User object" do
      expect(User).to receive(:decrement_counter)
        .with(:contributions_count, contribution.user_id)
    end

    it "decrements the contributions count on the associated Repository object" do
      expect(User).to receive(:decrement_counter)
        .with(:contributions_count, contribution.user_id)
    end
  end

end
