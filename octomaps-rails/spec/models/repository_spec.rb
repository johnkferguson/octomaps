require 'spec_helper'

describe Repository do
  it 'has a valid factory' do
    expect(build(:repository)).to be_valid
  end

  describe 'validations' do
    it 'validates presence of github_id' do
      expect(build(:repository, github_id: nil)).to_not be_valid
    end

    it 'validates uniqueness of github_id' do
      original = create(:repository)
      expect(build(:repository, github_id: original.github_id))
        .to have(1).errors_on(:github_id)
    end

    it 'validates presence of full_name' do
      expect(build(:repository, full_name: nil)).to_not be_valid
    end

    it 'validates uniqueness of full_name' do
      original = create(:repository)
      expect(build(:repository, full_name: original.full_name))
        .to have(1).errors_on(:full_name)
    end
  end
end
