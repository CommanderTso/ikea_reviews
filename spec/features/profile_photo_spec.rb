require "rails_helper"

feature "profile photo" do

  let (:user) do
    User.create(
      email: "asdf@asdf.com",
      password: "asdf1234"
    )
  end

  scenario "user uploads a profile photo when new user" do
    visit new_user_registration_path

    fill_in "Email", with: "ash@s-mart.com"
    fill_in "Password", with: "boomstick!3vilisd3ad"
    fill_in "Password confirmation", with: "boomstick!3vilisd3ad"
    attach_file "Profile photo", "#{Rails.root}/spec/support/images/photo.jpg"
    click_button "Sign up"

    expect(page).to have_content("Welcome! You have signed up successfully.")
    click_link "Edit Profile"
    expect(page).to have_css("img[src*='photo.jpg']")
  end

  scenario "user uploads a profile photo when editing profile" do
    user
    visit root_path
    click_link "Log in"
    fill_in "Email", with: "asdf@asdf.com"
    fill_in "Password", with: "asdf1234"
    click_button "Log in"

    click_link "Edit Profile"

    fill_in "Current password", with: "asdf1234"
    attach_file "Profile photo", "#{Rails.root}/spec/support/images/photo.jpg"
    click_button "Update"

    expect(page).to have_content("Your account has been updated successfully.")
    click_link "Edit Profile"
    expect(page).to have_css("img[src*='photo.jpg']")
  end
end
