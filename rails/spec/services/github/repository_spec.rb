require 'spec_helper'

describe Github::Repository do

  context 'when the repository can be found on github' do
    before { VCR.insert_cassette 'github/repository/octomaps_attributes' }
    after { VCR.eject_cassette }

    subject { described_class.new('JohnKellyFerguson/octomaps') }

    its(:attributes) { is_expected.to be_a(Sawyer::Resource) }
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
    its(:owner) { is_expected.to be_a(Sawyer::Resource) }

    its(:not_found?) { is_expected.to be_falsey }

    describe '#contributors' do
      its(:contributors) { is_expected.to be_a(Array) }

      it 'contains Github::Contributors' do
        subject.contributors.each do |contributor|
          expect(contributor).to be_a(Sawyer::Resource)
        end
      end
    end
  end

  context 'when the repository cannot be found on Github' do
    before { VCR.insert_cassette 'github/repository/notfound_attributes' }
    after { VCR.eject_cassette }

    subject { described_class.new('JohnKellyFerguson/notfound_repo') }

    describe '#attributes' do
      it 'is a NullObject' do
        expect(subject.attributes.class).to eq(NullObject)
      end
    end

    its(:full_name) { is_expected.to be_nil }
    its(:id) { is_expected.to be_nil }
    its(:name) { is_expected.to be_nil }
    its(:description) { is_expected.to be_nil }
    its(:homepage) { is_expected.to be_nil }
    its(:size) { is_expected.to be_nil }
    its(:fork) { is_expected.to be_nil }
    its(:forks_count) { is_expected.to be_nil }
    its(:stargazers_count) { is_expected.to be_nil }
    its(:watchers_count) { is_expected.to be_nil }
    its(:subscribers_count) { is_expected.to be_nil }
    its(:created_at) { is_expected.to be_nil }
    its(:updated_at) { is_expected.to be_nil }
    its(:pushed_at) { is_expected.to be_nil }
    its(:owner) { is_expected.to be_nil }

    its(:not_found?) { is_expected.to be_truthy }

    describe '#contributors' do
      it 'is a NullObject' do
        expect(subject.contributors.class).to eq(NullObject)
      end
    end
  end
end
