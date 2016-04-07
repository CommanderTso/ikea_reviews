require 'rails_helper'

# As a user, I'd like to create a review for an item.
#
# Done Criteria:
#
# User must rate the item at 1-5 stars
# User can enter a description of their review

# Open Items:
# - How long must reviews be?

feature "User creates a new review" do
  before(:each) do
    @item = create(:item_2)

    visit item_path(@item.id)
  end

  scenario "User sees fields to review item on its page", :vcr do
    expect(page).to have_content "We'd love your review of the #{@item.title}!"
    expect(page).to have_field "Rating:"
    expect(page).to have_field "Your Review:"
    expect(page).to have_button "Upload a picture of your #{item.title}"
  end

  scenario "User can enter & see a review for the item", :vcr do
    expect(page).to have_field "Rating:"
    select "3", from: "Rating:"
    fill_in "Your Review:", with: "Man, I love this furniture so much! " \
      "I drink so much coffee here, my kidneys are shot! Ow!"
    click_button "Submit"

    expect(page).to have_content "3"
    expect(page).to have_content "Man, I love this furniture so much! " \
      "I drink so much coffee here, my kidneys are shot! Ow!"
  end

  scenario "If the user doesn't enter a rating, reload and message them", :vcr do
    click_button "Submit"

    expect(page).to have_content("Rating must be between 1-5")
  end
end
