require 'spec_helper'

describe Person do
  it 'has a valid factory' do
    expect(build(:person)).to be_valid
  end

  describe 'validations' do
    it 'validates presence of github_id' do
      expect(build(:person, github_id: nil)).to_not be_valid
    end

    it 'validates uniqueness of github_id' do
      original = create(:person)
      expect(build(:person, github_id: original.github_id))
        .to have(1).errors_on(:github_id)
    end

    it 'validates presence of github_username' do
      expect(build(:person, github_username: nil)).to_not be_valid
    end

    it 'validates uniqueness of github_username' do
      original = create(:person)
      expect(build(:person, github_username: original.github_username))
        .to have(1).errors_on(:github_username)
    end
  end
end
