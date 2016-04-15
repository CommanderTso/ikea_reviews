require 'rails_helper'

# As a user, I'd like to see reviews for a given item.
#
# Done Criteria:
#
# - Reviews appear when the user goes to an item's page
# - Page displays average review score
# - Page displays reviews, sorted newest to oldest

feature "User sees reviews" do
  let!(:user) { create(:user) }
  let!(:user_2) { create(:user, email: "asdf@gmail.com") }
  let!(:user_3) { create(:user, email: "fdsa@gmail.com") }
  let!(:item) { create(:item) }
  let!(:review_1) { create(:review, item: item, user: user) }
  let!(:review_2) { create(:review, item: item, user: user_2) }
  let!(:review_3) { create(:review, item: item, user: user_3) }

  scenario "User sees average review score", :vcr do
    visit item_path(item)

    expect(page).to have_content "Average Review Score: 3.0"
  end

  scenario "User visits item show page to see reviews, sees page numbers for additional reviews", :vcr do
    item_2 = create(:item_with_100_reviews)
    visit item_path(item_2)
    expect(page).to have_link("2")
    expect(page).to have_link("3")
    expect(page).to have_link("Next ›")
    expect(page).to have_link("Last »")
  end

  scenario "User sees order newest to oldest", :vcr do
    visit item_path(item)

    within("ul#review_list") do
      expect(page).to have_selector("#review-0", text: review_3.description)
      expect(page).to have_selector("#review-1", text: review_2.description)
      expect(page).to have_selector("#review-2", text: review_1.description)
    end
  end
end
