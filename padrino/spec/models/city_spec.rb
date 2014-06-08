require 'spec_helper'

describe City do

  it { should respond_to(:name) }
  it { should have_many(:locations) }
  it { should belong_to(:country) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

end
