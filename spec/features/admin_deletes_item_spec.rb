require 'rails_helper'

feature "admin deletes an item" do

  User.create(
    email: "pinkpinksopink@gmail.com",
    password: "123123123",
    role: "admin"
  )

  Item.create(
    item_url: "http://www.ikea.com/us/en/catalog/products/80176284/",
    title: "HEMNES",
    subtitle: "Coffee table, black-brown",
    picture_url: "http://www.ikea.com/us/en/images/products/hemnes-coffee-table-brown__0104030_PE250678_S4.JPG",
    price: "139.00"
  )


  scenario "admin successfully deletes an item" do
    visit root_path
    click_link "Log in"
    fill_in "Email", with: "pinkpinksopink@gmail.com"
    fill_in "Password", with: "123123123"
    click_button "Log in"

    click_link "Admin Section"
    click_link "Items"
    expect(page).to have_content "HEMNES"

    click_button('Delete', match: :first)
    expect(page).to_not have_content "HEMNES"
  end
end
