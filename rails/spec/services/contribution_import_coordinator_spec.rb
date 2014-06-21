require 'spec_helper'

describe ContributionImportCoordinator do
  let(:coordinator) { described_class.new('JohnKellyFerguson/octomaps') }

  let(:contributor) do
    double(
      login: 'JohnKellyFerguson',
      id: 1,
      contributions: 50,
      avatar_url: 'avatar_url.com',
      gravatar_id: 'id'
    )
  end

  let(:github_repository) do
    double(
      full_name: 'JohnKellyFerguson/octomaps',
      id: 1,
      name: 'octomaps',
      description: 'description',
      homepage: 'http:://octomaps.com',
      size: 247,
      fork: false,
      forks_count: 3,
      stargazers_count: 13,
      watchers_count: 13,
      subscribers_count: 13,
      created_at: "2013-02-22T20:50:57Z",
      updated_at: "2014-03-15T20:17:22Z",
      pushed_at: "2014-03-15T20:17:22Z",
      contributors: [contributor],
      not_found?: false
    )
  end

  describe '#update_database_based_upon_github', :neo4j do
    before do
      allow(Github::Repository).to receive(:new).and_return(github_repository)
    end

    context 'when there is no matching repository in the database' do
      it 'creates a repository' do
        expect { coordinator.update_database_based_upon_github }
          .to change { Repository.count }.from(0).to(1)
      end
    end

    context 'when there is a matching repository in the database' do
      it 'updates the repository' do
        matching_repo = Repository.create(
          full_name: 'JohnKellyFerguson/octomaps',
          github_id: 1
        )

        coordinator.update_database_based_upon_github

        expect { matching_repo.reload }.to change { matching_repo.attributes }
      end
    end

    context 'when there are contributors in the db not connected to the repo' do
      it 'creates a contributed_to relationship between the person and repo' do
        unconnected_person = Person.create(
          github_username: 'JohnKellyFerguson', github_id: 1
        )

        expect { coordinator.update_database_based_upon_github }
          .to change { connected_relationship_count }
          .from(nil).to(1)
      end
    end

    context 'when there are contributors that are not in the database' do
      it 'creates each person and their contributed to relationship' do
        expect { coordinator.update_database_based_upon_github }
          .to change { connected_relationship_count }
          .from(nil).to(1)
      end
    end

    def connected_relationship_count
      Neo4j::Session.current._query("
        MATCH path=
        (repo:Repository {full_name: 'JohnKellyFerguson/octomaps'})
        <-[:`Person#contributed_to`]-
        (person:Person { github_username: 'JohnKellyFerguson' })
        RETURN length(path)
      ").data.flatten.first
    end
  end
end
