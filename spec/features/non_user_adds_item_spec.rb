require 'rails_helper'

feature "Non-user visits the website" do
  scenario 'not authorized user tries to add an item' do
    visit root_path
    click_link "Add a new item"

    expect(page.current_path).to eq new_user_registration_path
    expect(page).to have_content "Please sign up to add a new item!"
    expect(page).to have_content "Sign up"
    expect(page).to have_content "Email"
  end
end
