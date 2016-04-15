require 'rails_helper'

feature "delete", %{
  As an authenticed user
  I want to delete my account
  because I am unhappy
} do

  let!(:user) do
    create(
      :user,
      email: "asdf@asdf.com",
      password: "asdf1234"
    )
  end

  let!(:item) { create(:item_2) }

  let!(:review) do
    create(
      :review,
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
