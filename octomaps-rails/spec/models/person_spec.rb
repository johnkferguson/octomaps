require 'spec_helper'

describe Person do
  it 'has a valid factory' do
    expect(build(:person)).to be_valid
  end
end
