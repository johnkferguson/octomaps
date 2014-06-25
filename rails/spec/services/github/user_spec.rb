require 'spec_helper'

describe Github::User do

  context 'when the user can be found on github' do
    before { VCR.insert_cassette 'github/user/jkf_attributes' }
    after { VCR.eject_cassette }

    subject { described_class.new('JohnKellyFerguson') }

    its(:attributes) { is_expected.to be_a(Sawyer::Resource) }
    its(:login) { is_expected.to be_a(String) }
    its(:id) { is_expected.to be_a(Integer) }
    its(:name) { is_expected.to be_a(String) }
    its(:email) { is_expected.to be_a(String) }
    its(:location) { is_expected.to be_a(String) }
    its(:avatar_url) { is_expected.to be_a(String) }
    its(:gravatar_id) { is_expected.to be_a(String) }
    its(:company) { is_expected.to be_a(String) }
    its(:hireable) { is_expected.to be_a_boolean }
    its(:public_repos) { is_expected.to be_a(Integer) }
    its(:public_gists) { is_expected.to be_a(Integer) }
    its(:followers) { is_expected.to be_a(Integer) }
    its(:following) { is_expected.to be_a(Integer) }
    its(:created_at) { is_expected.to be_a(Time) }
    its(:updated_at) { is_expected.to be_a(Time) }

    its(:not_found?) { is_expected.to be_falsey }
  end

  context 'when the user cannot be found on github' do
    before { VCR.insert_cassette 'github/user/not_found_attributes' }
    after { VCR.eject_cassette }

    subject { described_class.new('unfindable_user') }

    describe '#attributes' do
      it 'is a NullObject' do
        expect(subject.attributes.class).to eq(NullObject)
      end
    end
    
    its(:login) { is_expected.to be_nil }
    its(:id) { is_expected.to be_nil }
    its(:name) { is_expected.to be_nil }
    its(:email) { is_expected.to be_nil }
    its(:location) { is_expected.to be_nil }
    its(:avatar_url) { is_expected.to be_nil }
    its(:gravatar_id) { is_expected.to be_nil }
    its(:company) { is_expected.to be_nil }
    its(:hireable) { is_expected.to be_nil }
    its(:public_repos) { is_expected.to be_nil }
    its(:public_gists) { is_expected.to be_nil }
    its(:followers) { is_expected.to be_nil }
    its(:following) { is_expected.to be_nil }
    its(:created_at) { is_expected.to be_nil }
    its(:updated_at) { is_expected.to be_nil }

    its(:not_found?) { is_expected.to be_truthy }
  end
end
