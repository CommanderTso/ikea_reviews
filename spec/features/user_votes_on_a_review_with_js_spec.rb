feature "User votes on a review (with AJAX)" do
  before(:each) do
    user = create(:user)
    item = create(:item)
    create(:review, item: item)

    visit root_path
    click_link "Log in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    visit item_path(item)
  end

  xscenario "User upvotes with AJAX enabled", js: true do

    expect_no_page_reload do
      expect(page).to have_content "We'd love your review of the"
      expect(page).to have_content("Review rating: 0")
      first(".upvote-0").click

      expect(page).to have_content("Review rating: 1")
    end
  end

  xscenario "User downvotes a review", js: true do
    expect_no_page_reload do
      expect(page).to have_content("Review rating: 0")
      first(".downvote-0").click

      expect(page).to have_content("Review rating: -1")
    end
  end

  xscenario "User removes their upvote", js: true do
    expect_no_page_reload do
      first(".upvote-0").click
      expect(page).to have_content("Review rating: 1")

      first(".upvote-0").click
      expect(page).to have_content("Review rating: 0")
    end
  end

  xscenario "User removes their downvote", js: true do
    expect_no_page_reload do
      first(".downvote-0").click
      expect(page).to have_content("Review rating: -1")

      first(".downvote-0").click
      expect(page).to have_content("Review rating: 0")
    end
  end

  xscenario "User changes their downvote to an upvote", js: true do
    expect_no_page_reload do
      first(".downvote-0").click
      expect(page).to have_content("Review rating: -1")

      first(".upvote-0").click
      expect(page).to have_content("Review rating: 1")
    end
  end

  xscenario "User changes their upvote to an downvote", js: true do
    expect_no_page_reload do
      first(".upvote-0").click
      expect(page).to have_content("Review rating: 1")

      first(".downvote-0").click
      expect(page).to have_content("Review rating: -1")
    end
  end
end
