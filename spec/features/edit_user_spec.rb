require 'rails_helper'

feature "edit", %{
  As an authenticated user
  I want to edit information
  so that I can change password
} do

  # ACCEPTANCE CRITERIA
  # - I must specify valid email address
  # - I must specify a password and confirm that password
  # - If I do not perform the above, I get an error message
  # - If I specific with valid information, I successfully update my account

  let (:user) do
    User.create(
    email: "asdf@asdf.com",
    password: "asdf1234"
    )
  end

  scenario 'user successfully changes password' do
    user

    visit new_user_session_path
    fill_in 'Email', with: "asdf@asdf.com"
    fill_in 'Password', with: "asdf1234"
    click_button "Log in"


    visit edit_user_registration_path
    fill_in 'Password', with: "password"
    fill_in 'Password confirmation', with: "password"
    fill_in 'Current password', with: "asdf1234"
    click_button 'Update'

    expect(page).to have_content("Your account has been updated successfully.")
    expect(page).to have_content("Sign Out")
  end

  scenario 'user enters incorrect current password' do
    user

    visit new_user_session_path
    fill_in 'Email', with: "asdf@asdf.com"
    fill_in 'Password', with: "asdf1234"
    click_button "Log in"


    visit edit_user_registration_path
    fill_in 'Password', with: "password"
    fill_in 'Password confirmation', with: "password"
    fill_in 'Current password', with: "fdsafdsa"
    click_button 'Update'

    expect(page).to have_content("1 error prohibited this user from
     being saved:")
    expect(page).to have_content("Current password is invalid")
  end

  scenario 'user enters invalid email' do
    user

    visit new_user_session_path
    fill_in 'Email', with: "asdf@asdf.com"
    fill_in 'Password', with: "asdf1234"
    click_button "Log in"

    visit edit_user_registration_path
    fill_in 'Email', with: "asdf@fdsaasdf"
    fill_in 'Password', with: "password"
    fill_in 'Password confirmation', with: "password"
    fill_in 'Current password', with: "asdf1234"
    click_button 'Update'

    expect(page).to have_content("Email is invalid")
  end
end
