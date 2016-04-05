require 'rails_helper'

feature "delete", %Q{
  As an authenticed user
  I want to delete my account
  because I am unhappy
} do

let (:user) do
  User.create(
  email: "asdf@asdf.com",
  password: "asdf1234"
  )
end

  scenario 'user successfully deletes account' do
    user

    visit new_user_session_path
    fill_in 'Email', with: "asdf@asdf.com"
    fill_in 'Password', with: "asdf1234"
    click_button "Log in"

    visit edit_user_registration_path
    click_button 'Delete my account'

    expect(page).to have_content("Bye! Your account has been successfully
     cancelled. We hope to see you again soon.")
    expect(page).to have_content("Sign Up")
  end
end
