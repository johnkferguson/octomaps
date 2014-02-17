require 'spec_helper'

describe Country do

  it { should respond_to(:name) }
  it { should have_many(:cities) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

end
