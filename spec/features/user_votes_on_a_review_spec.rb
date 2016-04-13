require 'rails_helper'

# Acceptance Criteria:
#
# - Reviews have a vote score
# -- Vote score is net value of all up and down votes
# - With no vote registered, upvoting or downvoting set the vote
# - Clicking again on an already-made vote removes it
# - Clicking on the other option after a vote is made switches it to the new choice
# - A user can only vote once per review
# - Feature must use AJAX to avoid page reloads

feature "User votes on a review" do
  before(:each) do
    user = create(:user)
    item = create(:item)
    create(:review, item: item)

    visit root_path
    click_link "Log in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    visit item_path(item)
  end

  scenario "User upvotes a review", :vcr do
    expect(page).to have_content "We'd love your review of the"

    expect(page.find('li#review-0')).to have_content("(Review rating: 0)")

    click_link("upvote-0")

    expect(page.find('li#review-0')).to have_content("(Review rating: 1)")
  end

  scenario "User downvotes a review", :vcr do
    expect(page.find('li#review-0')).to have_content("(Review rating: 0)")

    click_link("downvote-0")

    expect(page.find('li#review-0')).to have_content("(Review rating: -1)")
  end

  scenario "User removes their upvote", :vcr do
    click_link("upvote-0")
    expect(page.find('li#review-0')).to have_content("(Review rating: 1)")

    click_link("upvote-0")
    expect(page.find('li#review-0')).to have_content("(Review rating: 0)")
  end

  scenario "User removes their downvote", :vcr do
    click_link("downvote-0")
    expect(page.find('li#review-0')).to have_content("(Review rating: -1)")

    click_link("downvote-0")
    expect(page.find('li#review-0')).to have_content("(Review rating: 0)")
  end

  scenario "User changes their  to an upvote", :vcr do
    click_link("downvote-0")
    expect(page.find('li#review-0')).to have_content("(Review rating: -1)")

    click_link("upvote-0")
    expect(page.find('li#review-0')).to have_content("(Review rating: 1)")

  end

  scenario "User changes their upvote to an downvote", :vcr do
    click_link("upvote-0")
    expect(page.find('li#review-0')).to have_content("(Review rating: 1)")

    click_link("downvote-0")
    expect(page.find('li#review-0')).to have_content("(Review rating: -1)")
  end

  scenario "User tries to upvote and isn't logged in", :vcr do
    item = Item.find_or_create_by(title: "EKTORP")

    click_link "Sign Out"
    visit item_path(item)

    click_link("upvote-0")
    expect(page).to have_content "Please sign in to cast your vote!"
  end

  scenario "User tries to downvote and isn't logged in", :vcr do
    item = Item.find_or_create_by(title: "EKTORP")

    click_link "Sign Out"
    visit item_path(item)

    click_link("downvote-0")
    expect(page).to have_content "Please sign in to cast your vote!"
  end

end
