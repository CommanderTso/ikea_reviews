require 'rails_helper'

feature "user edits review" do
  let!(:user) do
    User.create(
      email: "asdf@gmail.com",
      password: "asdfasdf"
    )
  end

  let!(:user2) do
    User.create(
      email: "pinkpinksopink@gmail.com",
      password: "asdfasdf"
    )
  end

  let!(:item) do
    Item.create(
      item_url: "http://www.ikea.com/us/en/catalog/products/80176284/",
      title: "HEMNES",
      subtitle: "Coffee table, black-brown",
      picture_url: "http://www.ikea.com/us/en/images/products/hemnes-coffee-table-brown__0104030_PE250678_S4.JPG",
      price: "139.00"
    )
  end

  let!(:review) do
    Review.create(
      rating: 5,
      description: "Best I ever had.",
      item: item,
      user: user
    )
  end

  before(:each) do
    visit new_user_session_path
  end

  scenario "user views edit page of review" do
    fill_in "Email", with: "asdf@gmail.com"
    fill_in "Password", with: "asdfasdf"
    click_button "Log in"

    visit item_path(item)
    click_button "Edit"
    expect(page).to have_content "Edit your review of the #{item.title}"
    expect(page).to have_css('.edit_review')
  end

  scenario "user successfully edits review" do
    fill_in "Email", with: "asdf@gmail.com"
    fill_in "Password", with: "asdfasdf"
    click_button "Log in"

    visit item_path(item)
    click_button "Edit"
    select "3", from: "Rating:"
    fill_in "Your Review:", with: "Man, I love this furniture so much! " \
      "I drink so much coffee here, my kidneys are shot! Ow!"
    click_button "Submit"

    expect(page).to have_content "Review updated successfully!"
    expect(page.current_path).to eq item_path(item)
    expect(page).to have_content "Man, I love this furniture so much! " \
      "I drink so much coffee here, my kidneys are shot! Ow!"
  end

  scenario "user unsuccessfully edits review" do
    fill_in "Email", with: "asdf@gmail.com"
    fill_in "Password", with: "asdfasdf"
    click_button "Log in"

    visit item_path(item)
    click_button "Edit"
    fill_in "Your Review:", with: "Man, I love this furniture so much! " \
      "I drink so much coffee here, my kidneys are shot! Ow!"
    click_button "Submit"

    expect(page).to have_content "Rating must be between 1-5"
    expect(page).to have_content "Edit your review of the #{item.title}"
  end

  scenario "user who didn't write the review can't edit the review" do
    fill_in "Email", with: "pinkpinksopink@gmail.com"
    fill_in "Password", with: "asdfasdf"
    click_button "Log in"

    visit item_path(item)

    expect(page).to have_no_selector("input[type=submit][value='Edit']")
  end

  scenario "non-member can't edit a review" do
    visit item_path(item)

    expect(page).to have_no_selector("input[type=submit][value='Edit']")
  end

  scenario "user visits edit path of review he/she didn't edit" do
    visit edit_item_review_path(item, review)

    expect(page).to have_content "You are not authorized to view this page!"
  end
end
