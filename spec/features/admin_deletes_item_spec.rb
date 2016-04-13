require 'rails_helper'

feature "admin deletes an item" do
  before(:each) do
    create(:item_2)
    admin = create(:admin)

    visit root_path
    click_link "Log in"

    fill_in "Email", with: admin.email
    fill_in "Password", with: admin.password

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
    expect(page).to_not have_content "HEMNES"
  end
end
