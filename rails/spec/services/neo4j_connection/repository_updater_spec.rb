require 'spec_helper'

describe Neo4jConnection::RepositoryUpdater do
  let(:updater) { described_class.new(github_repository) }

  let(:github_repository) do
    Github::Repository.new('JohnKellyFerguson/octomaps')
  end

  let(:pre_existing_repo) do
    Repository.create(
      full_name: 'JohnKellyFerguson/octomaps',
      github_id: 1
    )
  end

  describe '#perform', :neo4j do
    before do
      allow(github_repository).to receive(:attributes).and_return(
        OpenStruct.new(
          full_name: 'JohnKellyFerguson/octomaps',
          id: 1,
          name: 'octomaps',
          description: 'Octomaps rocks!',
          homepage: 'http:://octomaps.com',
          size: 247,
          fork: false,
          forks_count: 3,
          stargazers_count: 13,
          watchers_count: 13,
          subscribers_count: 13,
          created_at: "2013-02-22T20:50:57Z",
          updated_at: "2014-03-15T20:17:22Z",
          pushed_at: "2014-03-15T20:17:22Z"
        )
      )
    end

    context 'when the repository was not found on github' do
      before { allow(github_repository).to receive(:not_found?) { true } }

      it 'does not create a new repository' do
        expect { updater.perform }.to_not change { Repository.count }
      end
    end

    context 'when a pre-existing repository needs an update' do
      before(:each) do
        allow(github_repository).to receive(:not_found?) { false }
        allow(pre_existing_repo).to receive(:needs_update?).and_return(true)
        updater.perform
      end

      it "does not change the repo's full name" do
        expect { pre_existing_repo.reload }
          .to_not change { pre_existing_repo.full_name }
      end

      it "does not change the repo's github_id" do
        expect { pre_existing_repo.reload }
          .to_not change { pre_existing_repo.github_id }
      end

      describe 'it changes all attributes that need to be updated' do
        def changes(attribute, from: nil, to:)
          expect { pre_existing_repo.reload }
            .to change { pre_existing_repo.send(attribute) }.from(from).to(to)
        end

        it { changes(:name, from: nil, to: 'octomaps') }
        it { changes(:description, from: nil, to: 'Octomaps rocks!') }
        it { changes(:homepage, from: nil, to: 'http:://octomaps.com') }
        it { changes(:size, from: nil, to: 247) }
        it { changes(:forked, from: nil, to: false) }
        it { changes(:github_forks_count, from: nil, to: 3) }
        it { changes(:github_stargazers_count, from: nil, to: 13) }
        it { changes(:github_watchers_count, from: nil, to: 13) }
        it { changes(:github_subscribers_count, from: nil, to: 13) }
        it do
          changes(
            :github_created_at,
            from: nil, to: DateTime.parse("2013-02-22T20:50:57Z")
          )
        end
        it do
          changes(
            :github_updated_at,
            from: nil, to: DateTime.parse("2014-03-15T20:17:22Z")
          )
        end
        it do
          changes(
            :github_pushed_at,
            from: nil, to: DateTime.parse("2014-03-15T20:17:22Z")
          )
        end
      end
    end

    context 'when a pre-existing repository does not need an update' do
      before do
        allow(github_repository).to receive(:not_found?) { false }
        allow(pre_existing_repo).to receive(:needs_update?).and_return(false)
      end

      it 'does not update the repository' do
        updater.perform

        expect(pre_existing_repo).to_not receive(:update!)
      end
    end

    context 'when there is no pre-existing repository' do
      before { allow(github_repository).to receive(:not_found?) { false } }

      it 'creates a new repository' do
        expect { updater.perform }.to change { Repository.count }.from(0).to(1)
      end
    end
  end
end
