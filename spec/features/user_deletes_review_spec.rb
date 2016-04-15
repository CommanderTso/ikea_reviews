require 'rails_helper'

feature "User deletes a review" do
  let!(:user) { create(:user) }
  let!(:user_2) { create(:user, email: "asdf@gmail.com") }
  let!(:item) { create(:item) }
  let!(:review) { create(:review, item: item, user: user) }

  before(:each) do
    visit new_user_session_path
  end

  scenario "User successfully deletes a review", :vcr do
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    visit item_path(item.id)
    expect(page).to have_content "Rating: #{review.rating}"
    expect(page).to have_content "Description: #{review.description}"

    click_button('Delete', match: :first)
    expect(page).to_not have_content "Rating: #{review.rating}"
    expect(page).to_not have_content "Description: #{review.description}"
  end

  scenario "User can only delete his/her own review" do
    fill_in "Email", with: user_2.email
    fill_in "Password", with: user_2.password
    click_button "Log in"

    visit item_path(item.id)
    expect(page).to have_content "Rating: #{review.rating}"
    expect(page).to have_content "Description: #{review.description}"
    expect(page).to have_no_selector("input[type=submit][value='Delete']")
  end
end
