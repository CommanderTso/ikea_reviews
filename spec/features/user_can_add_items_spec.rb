require 'rails_helper'

# As a user, I'd like to enter an Ikea item to create it on the review site.
# - User enters a URL or Article Number to an Ikea item
# - Site creates a page with pertinent information from the Ikea listing
# -- Item title
# -- Item subtitle
# -- Item description
# -- Picture
# -- Price
#
# - If the item is already created, just redirect user to that page
# - Page must message users appropriately for invalid URLs / article numbers

feature "User creates a new Ikea item" do
  scenario "User enters a URL to create a new item" do
    visit new_item_path
    expect(page).to have_content("Enter your item here:")
    expect(page).to have_content("Please enter an Ikea URL")

    fill_in "URL", with: "http://www.ikea.com/us/en/catalog/products/S99129122/"
    click_button "Submit"

    expect(page).to have_content "EKTORP"
    expect(page).to have_content "Footstool, Nordvalla light blue"
    expect(page).to have_content "149.00"
    expect(page).to have_css("img[src*='ektorp-footstool-blue__0386202_PE559152_S4.JPG']")
  end

  scenario "User doesn't enter any info for item" do
    visit new_item_path
    click_button "Submit"

    expect(page).to have_content "Please enter a valid Ikea product URL!"
    expect(page).to have_content "Enter your item here:"
  end

  scenario "User enters an item already created, gets sent to existing page" do
    item = FactoryGirl.create(:item)

    visit new_item_path
    fill_in "URL", with: item.item_url
    click_button "Submit"

    expect(current_path).to eq("/items/#{item.id}")
  end

  scenario "User enters an invalid URL to create a new item" do
    visit new_item_path
    fill_in "URL", with: "http://awdjhawkjdhawkjdhawkjdha"
    click_button "Submit"

    expect(page).to have_content("Please enter a valid Ikea product URL!")
    expect(page).to have_content("Enter your item here:")
  end
end
