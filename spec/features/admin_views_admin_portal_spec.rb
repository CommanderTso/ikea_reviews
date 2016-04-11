require 'rails_helper'

feature "admin login" do

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
      password: "123123123",
    )
  end

  before(:each) do
    visit root_path
    click_link "Log in"
  end

  scenario "admin successfully logs in and views admin portal" do
    fill_in "Email", with: "pinkpinksopink@gmail.com"
    fill_in "Password", with: "123123123"
    click_button "Log in"

    click_link "Admin Section"

    expect(page.current_path).to eq admins_path
    expect(page).to have_content "Users"
    expect(page).to have_content "Items"
    expect(page).to have_content "Reviews"
  end

  scenario "non-admin tries to access admin portal" do
    fill_in "Email", with: "asdf@gmail.com"
    fill_in "Password", with: "123123123"
    click_button "Log in"

    visit '/admins'

    expect(page.current_path).to eq root_path
    expect(page).to have_content "You are not authorized to view that page."
  end

  scenario "non-admin tries to access admin portal lists" do
    fill_in "Email", with: "asdf@gmail.com"
    fill_in "Password", with: "123123123"
    click_button "Log in"

    visit '/admins/users'
    expect(page.current_path).to eq root_path
    expect(page).to have_content "You are not authorized to view that page."

    visit '/admins/reviews'
    expect(page.current_path).to eq root_path
    expect(page).to have_content "You are not authorized to view that page."

    visit '/admins/items'
    expect(page.current_path).to eq root_path
    expect(page).to have_content "You are not authorized to view that page."
  end
end
