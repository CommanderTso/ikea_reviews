require 'rails_helper'

feature "admin deletes user" do

  let!(:admin) do
    User.create(
      email: "pinkpinksopink@gmail.com",
      password: "123123123",
      role: "admin"
    )
  end

  let!(:user) do
    User.create(
      email: "asdf@gmail.com",
      password: "123123123"
    )
  end

  before(:each) do
    visit root_path
    click_link "Log in"
    fill_in "Email", with: "pinkpinksopink@gmail.com"
    fill_in "Password", with: "123123123"
    click_button "Log in"
    click_link "Admin Section"
    click_link "Users"
  end

  scenario "admin views list of users" do
    expect(page).to have_content "List of all Users"
    expect(page).to have_content "asdf@gmail.com"
    expect(page).to have_content "pinkpinksopink@gmail.com"
  end

  scenario "admin successfully deletes users" do
    expect(page).to have_content "asdf@gmail.com"

    click_button('Delete', match: :first)
    expect(page).to_not have_content "asdf@gmail.com"
  end
end
