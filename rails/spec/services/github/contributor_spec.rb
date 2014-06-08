require 'spec_helper'

describe Github::Contributor do
  it_behaves_like 'a repository member' do
    describe '#contributions' do
      before { attributes.merge!(contributions: 1) }

      it 'returns the total number of contributions' do
        expect(member.contributions).to eq(1)
      end
    end
  end
end
