shared_examples 'a repository member' do
  let(:attributes) do
    {
      login: 'JohnKellyFerguson',
      id: 1,
      avatar_url: 'http:://octomaps.com',
      gravatar_id: 'id',
      type: 'User'
    }
  end

  let(:member) { described_class.new(attributes) }

  describe '#attributes' do
    it "returns all the member's attributes" do
      expect(member.attributes).to eq(attributes)
    end
  end

  describe '#login' do
    it "returns the member's login" do
      expect(member.login).to eq('JohnKellyFerguson')
    end
  end

  describe '#id' do
    it "returns the member's id" do
      expect(member.id).to eq(1)
    end
  end

  describe '#avatar_url' do
    it "returns the member's avatar_url" do
      expect(member.avatar_url).to eq('http:://octomaps.com')
    end
  end

  describe '#gravatar_id' do
    it "returns the member's gravatar_id" do
      expect(member.gravatar_id).to eq('id')
    end
  end

  describe '#type' do
    it "returns the member's type" do
      expect(member.type).to eq('User')
    end
  end
end
