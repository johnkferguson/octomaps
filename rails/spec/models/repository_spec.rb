require 'spec_helper'

describe Repository do
  it 'has a valid factory' do
    expect(build(:repository)).to be_valid
  end

  describe 'validations' do
    let(:original) { create(:repository) }

    it 'validates presence of github_id' do
      expect(build(:repository, github_id: nil)).to_not be_valid
    end

    it 'validates uniqueness of github_id' do
      duplicate = build(:repository, github_id: original.github_id)
      expect(duplicate).to_not be_valid
    end

    it 'validates presence of full_name' do
      expect(build(:repository, full_name: nil)).to_not be_valid
    end

    it 'validates uniqueness of full_name' do
      duplicate = build(:repository, full_name: original.full_name)
      expect(duplicate).to_not be_valid
    end
  end
end
