require 'rails_helper'

feature "sign up", %{
  As an unauthenticed user
  I want to sign up
  so that I can post reviews about items
} do

  # ACCEPTANCE CRITERIA
  # - I must specify valid email address
  # - I must specify a password and confirm that password
  # - If I do not perform the above, I get an error message
  # - If I specific with valid information, I register my account and am
  #  authenticated

  let!(:user) do
    User.create(
      email: "asdf@asdf.com",
      password: "asdf1234"
    )
  end

  scenario 'specifiying valid and required information' do
    visit new_user_registration_path
    fill_in 'Email', with: "Customer@ikea.com"
    fill_in 'Password', with: "password"
    fill_in 'Password confirmation', with: "password"
    click_button 'Sign up'

    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(page).to have_content("Sign Out")
  end

  scenario 'user enters the email that is already existing' do
    visit new_user_registration_path
    fill_in 'Email', with: "asdf@asdf.com"
    fill_in 'Password', with: "password"
    fill_in 'Password confirmation', with: "password"
    click_button 'Sign up'

    expect(page).to have_content("1 error prohibited this user from
     being saved:")
    expect(page).to have_content("Email has already been taken")
  end

  scenario 'user does not provide any information' do
    visit new_user_registration_path
    fill_in 'Email', with: ""
    fill_in 'Password', with: ""
    fill_in 'Password confirmation', with: ""
    click_button 'Sign up'

    expect(page).to have_content("2 errors prohibited this user from
     being saved:")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
  end

  scenario 'user provides invalid information' do
    visit new_user_registration_path
    fill_in 'Email', with: "asdf@asdf"
    fill_in 'Password', with: "asdf"
    fill_in 'Password confirmation', with: "asdf"
    click_button 'Sign up'

    expect(page).to have_content("2 errors prohibited this user from
     being saved:")
    expect(page).to have_content("Email is invalid")
    expect(page).to have_content("Password is too short")
  end
end
