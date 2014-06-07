require 'spec_helper'

describe Repository do
  it 'has a valid factory' do
    expect(build(:repository)).to be_valid
  end
end
