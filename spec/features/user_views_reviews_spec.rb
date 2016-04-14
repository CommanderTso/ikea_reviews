require 'rails_helper'

# As a user, I'd like to see reviews for a given item.
#
# Done Criteria:
#
# - Reviews appear when the user goes to an item's page
# - Page displays average review score
# - Page displays reviews, sorted newest to oldest

feature "User sees reviews" do
  before(:each) do
    @item = create(:item_with_3_reviews)
    @review_1 = @item.reviews.first
    @review_2 = @item.reviews.second
    @review_3 = @item.reviews.third
  end

  scenario "User sees average review score", :vcr do
    visit item_path(@item)

    expect(page).to have_content "Average Review Score: 3.33"
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
    visit item_path(@item)

    within("ul#review_list") do
      expect(page).to have_selector("li:nth-child(1)", text: @review_3.description)
      expect(page).to have_selector("li:nth-child(3)", text: @review_2.description)
      expect(page).to have_selector("li:nth-child(5)", text: @review_1.description)
    end
  end
end
