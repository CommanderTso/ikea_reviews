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
# - Page must message users appropriately for invalid URLs / article numbes

feature "User creates a new Ikea item" do
  scenario "User enters a URL to create a new item" do
    item_url = "http://www.ikea.com/us/en/catalog/products/S99129122/"

    visit new_item_path
    expect(page).to have_content("Enter your item here:")
    expect(page).to have_content("Please use the Ikea URL or the item's " \
      "article number")

    fill_in "URL", with: item_url
    click_button "Submit"

    expect(page).to have_content "EKTORP"
    expect(page).to have_content "Footstool, Nordvalla light blue"
    expect(page).to have_content "149.00"
    image_name = 'ektorp-footstool-blue__0386202_PE559152_S4.JPG'
    expect(page).to have_css("img[src*=#{image_name}]")
  end

  scenario "User doesn't enter any info for item" do
    visit new_item_path
    click_button "Submit"

    expect(page).to have_content "Please enter a valid Ikea product URL or " \
      "Article Number!"
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

    expect(page).to have_content("Please enter a valid Ikea product URL " \
      "or Article Number!")
    expect(page).to have_content("Enter your item here:")
  end

  xscenario "User enters an Article Number to create a new item" do
  end

  xscenario "User enters an Article Number & a URL to create a new item" do
  end

  xscenario "User enters an invalid Article Number to create a new item" do
  end

end
