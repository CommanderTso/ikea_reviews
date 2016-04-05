require 'rails_helper'


feature "sign up", %Q{
  As an unauthenticed user
  I want to sign up
  so that I can post reviews about items
} do

#ACCEPTANCE CRITERIA
# - I must specify valid email address
# - I must specify a password and confirm that password
# - If I do not perform the above, I get an error message
# - If I specific with valid information, I register my account and am authenticated

  scenario 'specifiying valid and required information' do
    visit new_user_registration_path
    fill_in 'Email', with: "Customer@ikea.com"
    fill_in 'Password', with: "password"
    fill_in 'Password confirmation', with: "password"
    click_button 'Sign up'

    expect(page).to have_content("You're in!")
    expect(page).to have_content("Sign Out")
  end
end
