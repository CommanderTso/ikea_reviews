require 'rails_helper'

# As a user I want to view a list of items So that I can pick items to review

# Visiting "/" "/items" gets you the items#index page
# Page should links to all items in database
# Links should lead to item show pages

feature "User views index page to see items" do
  before(:each) do
    @item1 = create(:item_1)
    @item2 = create(:item_2)
  end

  scenario "User visits '/', gets redirected to /items" do
    visit root_path

    expect(page).to have_content "Welcome to EyeKea!"
    expect(page).to have_content @item2.title
    expect(page).to have_content @item1.title
  end

  scenario "User visits '/items', sees list of items & link to add more" do
    visit items_path

    expect(page).to have_content "Welcome to EyeKea!"
    expect(page).to have_link @item1.title
    expect(page).to have_link @item2.title
    expect(page).to have_link "Add a new item"
  end

  # scenario "User visits '/items', sees page links." do
  #   binding.pry
  # end

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

    click_link @item1.title

    expect(page).to have_content @item1.title
    expect(page).to have_content @item1.subtitle
    expect(page).to have_xpath("/html/body/img[@src='#{@item1.picture_url}']")
  end

  scenario "Clicking Add Item takes you the user to the add item page" do
    visit items_path

    click_link "Add a new item"

    expect(page).to have_content "Enter your item here:"
    expect(page).to have_content "Please enter an Ikea URL"
  end
end
