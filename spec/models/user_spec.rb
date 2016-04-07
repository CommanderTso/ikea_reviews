require 'rails_helper'

describe User do
  it { should have_valid(:email).when('abcd@gmail.com', 'dcba@mailg.com') }
  it { should_not have_valid(:email).when(
    nil,
    '',
    'abc',
    'users@come',
    'usersba.com'
    ) }

  it 'has a matching password confirmation for the password' do
    user = User.new
    user.password = 'password'
    user.password_confirmation = 'anotherpassword'

    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank
  end
end

describe "#admin?" do
  it "is not an admin if the role is not admin" do
    user = FactoryGirl.create(:user, role: "member")
    expect(user.admin?).to eq(false)
  end

  it "is an admin if the role is admin" do
    user = FactoryGirl.create(:user, role: "admin")
    expect(user.admin?).to eq(true)
  end
end
