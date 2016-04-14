require 'rails_helper'

feature "admin deletes a review" do
  before(:each) do
    admin = create(:admin)

    visit root_path
    click_link "Log in"

    fill_in "Email", with: admin.email
    fill_in "Password", with: admin.password
    click_button "Log in"

    click_link "Admin Section"
  end

  scenario "admin views list of reviews" do
    item = create(:item_with_3_reviews)
    click_link "Reviews"

    expect(page).to have_content "List of all Reviews"
    expect(page).to have_content item.title
    expect(page).to have_content item.reviews.first.description
    expect(page).to have_content item.reviews.second.description
    expect(page).to have_content item.reviews.third.description
  end

  scenario "admin successfully deletes a review" do
    item = create(:item_with_3_reviews)
    review_one_description = item.reviews.first.description
    click_link "Reviews"

    expect(page).to have_content item.title
    expect(page).to have_content item.reviews.first.description
    expect(page).to have_content item.reviews.second.description
    expect(page).to have_content item.reviews.third.description

    click_button('Delete', match: :first)
    expect(page).to_not have_content review_one_description
  end
end
