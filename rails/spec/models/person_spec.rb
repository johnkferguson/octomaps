require 'spec_helper'

describe Person do
  it 'has a valid factory' do
    expect(build(:person)).to be_valid
  end

  describe 'validations' do
    let(:original) { create(:person) }

    it 'validates presence of github_id' do
      expect(build(:person, github_id: nil)).to_not be_valid
    end

    it 'validates uniqueness of github_id' do
      duplicate = build(:person, github_id: original.github_id)
      expect(duplicate).to_not be_valid
    end

    it 'validates presence of github_username' do
      expect(build(:person, github_username: nil)).to_not be_valid
    end

    it 'validates uniqueness of github_username' do
      duplicate = build(:person, github_username: original.github_username)
      expect(duplicate).to_not be_valid
    end
  end

  describe '.persisted_usernames_from(usernames_array)' do
    it 'returns only the usernames that have already been persisted' do
      joe = create(:person, github_username: 'joe')
      carl = create(:person, github_username: 'carl')

      expect(Person.persisted_usernames_from(usernames_array: ['joe', 'carl', 'john']))
        .to contain_exactly('joe', 'carl')
    end
  end
end
