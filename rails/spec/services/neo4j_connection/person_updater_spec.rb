require 'spec_helper'

describe Neo4jConnection::PersonUpdater do
  let(:updater) { described_class.new(github_username: 'JohnKellyFerguson') }
  let(:person) { create(:person, github_username: 'JohnKellyFerguson') }
  let(:github_user) { Github::User.new('JohnKellyFerguson') }

  describe '#perform', :neo4j do
    before do
      allow(Github::User).to receive(:new).and_return(github_user)
      allow(github_user).to receive(:attributes).and_return(
        OpenStruct.new(
          login: person.github_username,
          id: person.github_id,
          name: 'John',
          email: 'hello@johnkellyferguson.com',
          location: 'New York, NY',
          avatar_url: 'https://avatars.githubusercontent.com/u/2823694?',
          gravatar_id: 'b58b357a352eda178941fd2dfd5c6d5d',
          company: 'AlphaSights',
          blog: 'johnwritecode.com',
          hireable: true,
          public_repos: 18,
          public_gists: 9,
          followers: 22,
          following: 60,
          created_at: '2012-11-17T20:50:57Z',
          updated_at: '2014-06-25T20:17:22Z'
        )
      )
    end

    def updates_the(attribute:, on:)
      updater.perform
      expect { on.reload }.to change { on.send(attribute) }
    end

    it { updates_the(attribute: :name, on: person) }
    it { updates_the(attribute: :email, on: person) }
    it { updates_the(attribute: :github_location, on: person) }
    it { updates_the(attribute: :avatar_url, on: person) }
    it { updates_the(attribute: :gravatar_id, on: person) }
    it { updates_the(attribute: :company, on: person) }
    it { updates_the(attribute: :blog, on: person) }
    it { updates_the(attribute: :hireable, on: person) }
    it { updates_the(attribute: :github_public_repos_count, on: person) }
    it { updates_the(attribute: :github_public_gists_count, on: person) }
    it { updates_the(attribute: :github_followers_count, on: person) }
    it { updates_the(attribute: :github_following_count, on: person) }
    it { updates_the(attribute: :github_created_at, on: person) }
    it { updates_the(attribute: :github_updated_at, on: person) }

    context 'when the user was not found on github' do
      before do
        allow(github_user).to receive(:not_found?) { true }
        updater.perform
      end

      it "does not update the person's attributes" do
        expect { person.reload }.to_not change { person.attributes }
      end
    end
  end
end
