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
