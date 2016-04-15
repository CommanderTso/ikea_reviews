require 'rails_helper'

feature 'search' do

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

  scenario 'user successfully searches for item' do
    visit root_path
    fill_in "search", with: "hemnes"
    click_button 'Search'
    expect(page).to have_content 'HEMNES'
    expect(page).to_not have_content 'EKTORP'
  end

  scenario 'user does a blank search' do
    visit root_path
    fill_in "search", with: ""
    click_button 'Search'

    expect(page).to have_content "Please enter a search term to search for products!"
    expect(page).to have_content 'HEMNES'
    expect(page).to have_content 'EKTORP'
  end
end
