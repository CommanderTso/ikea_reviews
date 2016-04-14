require 'rails_helper'

feature "admin deletes an item" do

  let!(:admin) do
    User.create(
      email: "pinkpinksopink@gmail.com",
      password: "123123123",
      role: "admin"
    )
  end

  let!(:item) do
    Item.create(
      item_url: "http://www.ikea.com/us/en/catalog/products/80176284/",
      title: "HEMNES",
      subtitle: "Coffee table, black-brown",
      picture_url: "http://www.ikea.com/us/en/images/products/hemnes-coffee-table-brown__0104030_PE250678_S4.JPG",
      price: "139.00"
    )
  end

  before(:each) do
    visit root_path
    click_link "Log in"
    fill_in "Email", with: "pinkpinksopink@gmail.com"
    fill_in "Password", with: "123123123"
    click_button "Log in"
    click_link "Admin Section"
    click_link "Items"
  end

  scenario "admin views list of items" do
    expect(page).to have_content "List of all Items"
    expect(page).to have_content "HEMNES"
  end

  scenario "admin successfully deletes an item" do
    expect(page).to have_content "HEMNES"

    click_button('Delete', match: :first)
    expect(page).to have_content "HEMNES has been deleted!"
    expect(page).to have_no_selector("input[type=submit][value='Delete']")
  end
end
