require 'rails_helper'

feature "user edits review" do
  let!(:user) { create(:user) }
  let!(:user_2) { create(:user, email: "asdf@gmail.com") }
  let!(:item) { create(:item) }
  let!(:review) { create(:review, item: item, user: user) }

  before(:each) do
    visit new_user_session_path
  end

  scenario "user views edit page of review" do
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    visit item_path(item)
    click_button "Edit"
    expect(page).to have_content "Edit your review of the #{item.title}"
    expect(page).to have_css('.edit_review')
  end

  scenario "user successfully edits review" do
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    visit item_path(item)
    click_button "Edit"
    select "3", from: "Rating:"
    fill_in "Your Review:", with: "Pizzzzzzza"
    click_button "Submit"

    expect(page).to have_content "Review updated successfully!"
    expect(page.current_path).to eq item_path(item)
    expect(page).to have_content "Pizzzzzzza"
  end

  scenario "user unsuccessfully edits review" do
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    visit item_path(item)
    click_button "Edit"
    fill_in "Your Review:", with: "Pizzzzzzza"
    click_button "Submit"

    expect(page).to have_content "Rating must be between 1-5"
    expect(page).to have_content "Edit your review of the #{item.title}"
  end

  scenario "user who didn't write the review can't edit the review" do
    fill_in "Email", with: user_2.email
    fill_in "Password", with: user_2.password
    click_button "Log in"

    visit item_path(item)

    expect(page).to have_no_selector("input[type=submit][value='Edit']")
  end

  scenario "non-member can't edit a review" do
    visit item_path(item)

    expect(page).to have_no_selector("input[type=submit][value='Edit']")
  end

  scenario "user visits edit path of review he/she didn't create" do
    visit edit_item_review_path(item, review)

    expect(page).to have_content "You are not authorized to view this page!"
  end
end
