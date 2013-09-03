require 'spec_helper'

describe User do
  before(:each) do
    @user = User.new(username: "JohnKellyFerguson",
      avatar_url: "https://secure.gravatar.com/avatar/b58b357a352eda178941fd2dfd5c6d5d",
      gravatar_id: "b58b357a352eda178941fd2dfd5c6d5d", email: "hello@johnkellyferguson.com")
  end

  subject { @user }

  it { should respond_to(:username) }
  it { should respond_to(:gravatar_id) }
  it { should respond_to(:email) }
  it { should have_many(:contributions) }
  it { should have_many(:repositories).through(:contributions) }

  describe "when username is not present" do
    before { @user.username = "" }
    it { should_not be_valid }
  end

  describe "when username is present" do
    before { @user.username = "username" }
    it { should be_valid }
  end

  describe "when username is already taken" do
    before do
      user_with_same_username = @user.dup
      user_with_same_username.username = @user.username
      user_with_same_username.save
    end

    it { should_not be_valid }
  end

end
