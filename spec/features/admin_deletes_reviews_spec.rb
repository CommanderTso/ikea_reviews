require 'rails_helper'

feature "admin deletes a review" do

  let!(:admin) do
    User.create(
      email: "pinkpinksopink@gmail.com",
      password: "123123123",
      role: "admin"
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
      item: item,
      user: admin,
      rating: 5,
      description: "Great!"
    )
  end

  let!(:review2) do
    Review.create(
      item: item,
      user: admin,
      rating: 1,
      description: "Wasted money. I'll never ever shop at Ikea!"
    )
  end

  before(:each) do
    visit root_path
    click_link "Log in"
    fill_in "Email", with: "pinkpinksopink@gmail.com"
    fill_in "Password", with: "123123123"
    click_button "Log in"
    click_link "Admin Section"
    click_link "Reviews"
  end

  scenario "admin views list of reviews" do
    expect(page).to have_content "List of all Reviews"
    expect(page).to have_content "HEMNES"
    expect(page).to have_content "5 - Great!"
    expect(page).to have_content "1 - Wasted money. I'll never ever shop at
     Ikea!"
  end

  scenario "admin successfully deletes a review" do
    expect(page).to have_content "HEMNES"
    expect(page).to have_content "5 - Great!"
    expect(page).to have_content "1 - Wasted money. I'll never ever shop at
     Ikea!"

    click_button('Delete', match: :first)
    expect(page).to_not have_content "5 - Great!"
  end
end
