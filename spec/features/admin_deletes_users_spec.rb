require 'rails_helper'

feature "admin login" do

  User.create(
    email: "pinkpinksopink@gmail.com",
    password: "123123123",
    role: "admin"
  )

  scenario "admin successfully deletes users" do
    visit root_path
    click_link "Log in"
    fill_in "Email", with: "pinkpinksopink@gmail.com"
    fill_in "Password", with: "123123123"
    click_button "Log in"

    click_link "Admin Section"

    expect(page.current_path).to eq admins_path
    expect(page).to have_content "Users"
    expect(page).to have_content "Items"
    expect(page).to have_content "Reviews"
  end
end
