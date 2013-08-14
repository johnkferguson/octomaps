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

end
