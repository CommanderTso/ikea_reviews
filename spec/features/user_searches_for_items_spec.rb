require 'rails_helper'

feature 'search' do

  let!(:item_1) do
    create(:item)
  end

  let!(:item_2) do
    create(:item_2)
  end

  xscenario 'user successfully searches for item' do
    visit root_path
    expect(page).to have_content 'HEMNES'
    expect(page).to have_content 'EKTORP'
    fill_in "search", with: "hemnes"
    page.find("#search-button").click
    expect(page).to have_content 'HEMNES'
    expect(page).to_not have_content 'EKTORP'
  end

  xscenario 'user does a blank search' do
    visit root_path
    fill_in "search", with: ""
    click_button 'Search!'

    expect(page).to have_content "Please enter a search term to search for products!"
    expect(page).to have_content 'HEMNES'
    expect(page).to have_content 'EKTORP'
  end
end
