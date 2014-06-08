require 'spec_helper'

describe Github::Repository do
  before { VCR.insert_cassette 'github/repository/octomaps_attributes' }
  after { VCR.eject_cassette }

  subject { described_class.new('JohnKellyFerguson/octomaps') }

  its(:attributes) { is_expected.to be_a(Hash) }
  its(:full_name) { is_expected.to be_a(String) }
  its(:id) { is_expected.to be_a(Integer) }
  its(:name) { is_expected.to be_a(String) }
  its(:description) { is_expected.to be_a(String) }
  its(:homepage) { is_expected.to be_a(String) }
  its(:size) { is_expected.to be_a(Integer) }
  its(:fork) { is_expected.to be_a_boolean }
  its(:forks_count) { is_expected.to be_a(Integer) }
  its(:stargazers_count) { is_expected.to be_a(Integer) }
  its(:watchers_count) { is_expected.to be_a(Integer) }
  its(:subscribers_count) { is_expected.to be_a(Integer) }
  its(:created_at) { is_expected.to be_a(Time) }
  its(:updated_at) { is_expected.to be_a(Time) }
  its(:pushed_at) { is_expected.to be_a(Time) }
  its(:owner) { is_expected.to be_a(Github::Owner) }

  describe '#contributors' do
    its(:contributors) { is_expected.to be_a(Array) }

    it 'contains Github::Contributors' do
      subject.contributors.each do |contributor|
        expect(contributor).to be_a(Github::Contributor)
      end
    end
  end
end
