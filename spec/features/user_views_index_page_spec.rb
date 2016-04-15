require 'rails_helper'

# As a user I want to view a list of items So that I can pick items to review

# Visiting "/" "/items" gets you the items#index page
# Page should links to all items in database
# Links should lead to item show pages

feature "User views index page to see items" do
  let!(:user) do
    User.create(
      email: "asdf@asdf.com",
      password: "asdf1234"
    )
  end

  let!(:item1) do
    create(:item)
  end

  let!(:item2) do
    create(
      :item,
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
    fill_in 'Email', with: "asdf@asdf.com"
    fill_in 'Password', with: "asdf1234"
    click_button "Log in"
  end

  scenario "User visits '/', gets redirected to /items" do
    visit root_path

    expect(page).to have_content "Welcome to EyeKea!"
    expect(page).to have_content "The premier review site for Ikea furniture"
    expect(page).to have_content item2.title
    expect(page).to have_content item1.title
  end

  scenario "User visits '/items', sees list of items & link to add more" do
    visit items_path

    expect(page).to have_content "Welcome to EyeKea!"
    expect(page).to have_link item1.title
    expect(page).to have_link item2.title
    expect(page).to have_link "Add an Item"
  end

  scenario "User visits '/items', sees page numbers for additional items", :vcr do
    (1..100).each do |n|
      create(
        :item,
        title: "TESTITEM#{n}",
        item_url: "http://www.ikea.com/us/en/catalog/products/#{10000000 + n}/"
      )
    end

    visit items_path
    expect(page).to have_link("2")
    expect(page).to have_link("3")
    expect(page).to have_link("Next ›")
    expect(page).to have_link("Last »")
  end

  scenario "User clicks item link, gets taken to items#show page" do
    visit items_path

    click_link item1.title

    expect(page).to have_content item1.title
    expect(page).to have_content item1.subtitle
    # binding.pry
    expect(page).to have_xpath("//img[@src='#{item1.picture_url}']")
  end

  scenario "Clicking Add Item takes you the user to the add item page" do
    visit items_path

    click_link "Add an Item"

    expect(page).to have_content "Please enter an Ikea URL"
  end
end
