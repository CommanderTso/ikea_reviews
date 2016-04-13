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
  let!(:item) { create(:item_with_3_reviews) }
  # WE SHOULD CREATE A BUNCH OF VOTES ON THESE REVIEWS

  scenario "User upvotes a review", :vcr do
    visit item_path(item)

    expect(page).to have_content "Average Review Score: 3.33"
    expect(page).to have_content "We'd love your review of the #{item.title}!"

    find('//img#upvote-0').click

    expect(page).to have_css("PUT CSS HERE")
  end

  scenario "User downvotes a review", :vcr do

  end

  scenario "User removes their upvote", :vcr do

  end

  scenario "User removes their downvote", :vcr do

  end

  scenario "User changes their downvote to an upvote", :vcr do

  end

  scenario "User changes their upvote to an downvote", :vcr do

  end


end
