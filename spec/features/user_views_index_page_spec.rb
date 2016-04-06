require 'rails_helper'

# As a user I want to view a list of items So that I can pick items to review

# Visiting "/" "/items" gets you the items#index page
# Page should links to all items in database
# Links should lead to item show pages

feature "User views index page to see items" do
  before(:each) do
    FactoryGirl.create(:item)
    FactoryGirl.create(:item,
      item_url: "http://www.ikea.com/us/en/catalog/products/80176284/",
      title: "HEMNES",
      subtitle: "Coffee table, black-brown",
      picture_url: "http://www.ikea.com/us/en/images/products/hemnes-coffee-table-brown__0104030_PE250678_S4.JPG",
      price: "139.00"
      )
  end

  scenario "User visits '/', gets redirected to /items" do
    visit root_path

    expect(page).to have_content "Welcome to EyeKea!"
    expect(page).to have_content "HEMNES"
    expect(page).to have_content "EKTORP"
  end

  scenario "User visits '/items', sees list of items & link to add more" do
    visit items_path

    expect(page).to have_content "Welcome to EyeKea!"
    expect(page).to have_link "HEMNES"
    expect(page).to have_link "EKTORP"
    expect(page).to have_link "Add a new item"
  end

  scenario "User clicks item link, gets taken to items#show page" do
    visit items_path

    click_link "HEMNES"

    expect(page).to have_content "Coffee table, black-brown"
    expect(page).to have_content "HEMNES"
    expect(page).to have_css("img[src*='hemnes-coffee-table-brown__0104030_PE250678_S4.JPG']")
  end

  scenario "Clicking Add Item takes you the user to the add item page" do
    visit items_path

    click_link "Add a new item"

    expect(page).to have_content "Enter your item here:"
    expect(page).to have_content "Please enter an Ikea URL"
  end
end
