require 'rails_helper'

feature "User deletes a review" do
  let!(:user) do
    User.create(
      email: "asdf@asdf.com",
      password: "asdf1234"
    )
  end

  let!(:user2) do
    User.create(
      email: "pinkpinksopink@gmail.com",
      password: "31231231213"
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

  scenario "User successfully deletes a review", :vcr do
    fill_in "Email", with: "asdf@asdf.com"
    fill_in "Password", with: "asdf1234"
    click_button "Log in"

    visit item_path(item.id)
    expect(page).to have_content "5 - Best I ever had."

    click_button('Delete', match: :first)
    expect(page).to_not have_content "5 - Best I ever had."
  end

  scenario "User can only delete his/her own review" do
    visit new_user_session_path
    fill_in "Email", with: "pinkpinksopink@gmail.com"
    fill_in "Password", with: "31231231213"
    click_button "Log in"

    visit item_path(item.id)
    expect(page).to have_no_selector("input[type=submit][value='Delete']")
  end
end
