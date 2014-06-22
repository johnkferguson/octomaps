require 'spec_helper'

describe Repository do
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

  describe '#needs_update?', :neo4j do
    let(:persisted_repo) { create(:repository, github_updated_at: 1.weeks.ago) }

    context 'when the repo is persisted with a different github_updated_at' do
      it 'returns true' do
        expect(
          persisted_repo.needs_update?(github_updated_datetime: DateTime.new)
        ).to be_truthy
      end
    end

    context 'when the repo is persisted and has the same github_updated_at' do
      it 'returns false' do
        expect(
          persisted_repo.needs_update?(
            github_updated_datetime: persisted_repo.github_updated_at
          )
        ).to be_falsey
      end
    end

    context 'when the repo has not been persisted' do
      it 'returns true' do
        unpersisted_repo = build(:repository)
        expect(
          unpersisted_repo.needs_update?(github_updated_datetime: DateTime.new)
        ).to be_truthy
      end
    end
  end
end
