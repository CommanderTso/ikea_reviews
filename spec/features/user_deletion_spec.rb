require 'rails_helper'

feature "delete", %{
  As an authenticed user
  I want to delete my account
  because I am unhappy
} do

  let!(:user) do
    User.create(
      email: "asdf@asdf.com",
      password: "asdf1234"
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
      user: user,
      rating: 5,
      description: "Great!"
    )
  end

  before(:each) do
    visit new_user_session_path
    fill_in 'Email', with: "asdf@asdf.com"
    fill_in 'Password', with: "asdf1234"
    click_button "Log in"

    visit edit_user_registration_path
    click_button 'Delete my account'
  end

  scenario 'user successfully deletes account' do
    expect(page).to have_content("Your account has been deleted.
     You will be missed!")
    expect(page).to have_content("Sign Up")
  end

  scenario 'user review is deleted when account is deleted' do
    visit item_path(item)

    expect(page).to_not have_content "5 - Great!"
    expect(page).to have_content "No reviews yet!"
  end
end
