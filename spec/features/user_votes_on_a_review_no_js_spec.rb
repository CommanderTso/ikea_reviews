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

feature "User votes on a review (no ajax)" do
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

  scenario "User upvotes a review" do
    expect(page).to have_content "We'd love your review of the"

    expect(page).to have_content("🔑 : 0")
    first(".upvote-0").click

    expect(page).to have_content("🔑 : 1")
  end

  scenario "User downvotes a review" do
    expect(page).to have_content("🔑 : 0")

    first(".downvote-0").click

    expect(page).to have_content("🔑 : -1")
  end

  scenario "User removes their upvote" do
    first(".upvote-0").click
    expect(page).to have_content("🔑 : 1")

    first(".upvote-0").click
    expect(page).to have_content("🔑 : 0")
  end

  scenario "User removes their downvote" do
    first(".downvote-0").click
    expect(page).to have_content("🔑 : -1")

    first(".downvote-0").click
    expect(page).to have_content("🔑 : 0")
  end

  scenario "User changes their downvote to an upvote" do
    first(".downvote-0").click
    expect(page).to have_content("🔑 : -1")

    first(".upvote-0").click
    expect(page).to have_content("🔑 : 1")

  end

  scenario "User changes their upvote to an downvote" do
    first(".upvote-0").click
    expect(page).to have_content("🔑 : 1")

    first(".downvote-0").click
    expect(page).to have_content("🔑 : -1")
  end
end
