require 'rails_helper'

# As a user, I'd like to click on a category to get links to the items it contains.
#
# Done Criteria:
#
# - There is a pull-down in the header to view category pages
# - Clicking a category link gives you a list of all items in that category
# - An item's category is shown on its show page & is a clickable link

feature "Site has a category attached to each item" do
  scenario "User can select from a pull-down to view a category's items", :vcr do
    visit root_path

    expect(page).to have_content "View by Category:"

    select "Living Room", from: "categories"

    expect(page).to have_link("TILLFÄLLE")
    expect(page).to have_link("ALÄNG")
    expect(page).to have_link("EKTORP")

    click_link("ALÄNG")

    expect(page).to have_content("ALÄNG")
    expect(page).to have_content("Ceiling lamp, white")
    expect(page).to have_content("$29.99")
  end

  scenario "An item show page has a clickable link to the category show page" do
    visit root_path
    click_link("TILLFÄLLE")

    expect(page).to have_link "Living Room"

    click_link "Living Room"

    expect(page).to have_link("TILLFÄLLE")
    expect(page).to have_link("ALÄNG")
    expect(page).to have_link("EKTORP")
  end
end
