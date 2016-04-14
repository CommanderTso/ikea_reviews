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

feature "User votes on a review without logging in" do
  before(:each) do
    item = create(:item)
    create(:review, item: item)

    visit item_path(item)
  end

  scenario "User tries to upvote and isn't logged in" do
    first(".upvote-0").click
    expect(page).to have_content "Please sign in to cast your vote!"
  end

  scenario "User tries to downvote and isn't logged in" do
    first(".downvote-0").click
    expect(page).to have_content "Please sign in to cast your vote!"
  end
end
