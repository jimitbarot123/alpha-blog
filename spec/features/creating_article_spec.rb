require "rails_helper"

RSpec.feature "Creating Articles" do

  before do
    @jimit = User.create!(username: "testuser", email: "test2@example.com", password: "password", superadmin_role: true)
    login_as(@jimit)
  end

  scenario "A user creates a new article" do
    visit "/"

    expect(page.current_path).to eq(articles_path)

    click_link "Create new article"

    expect(page.current_path).to eq(new_article_path)
    expect(page).to have_content("Create a new article")

    fill_in "title", with: "Creating a blog"
    fill_in "description", with: "Description for blog"

    click_button "Create Article"

    expect(Article.last.user).to eq(@jimit)
    expect(page).to have_content("Article was created successfully.")
    expect(page.current_path).to eq(articles_path)
    expect(page).to have_content("by #{@jimit.username}")
  end

  scenario "A user fails to create a new article" do
    visit "/"

    click_link "Create new article"

    expect(page.current_path).to eq(new_article_path)
    expect(page).to have_content("Create a new article")

    click_button "Create Article"

    fill_in "title", with: ""
    fill_in "description", with: ""

    #expect(page).to have_content("Article has not been created")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Title is too short (minimum is 6 characters)")
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Description is too short (minimum is 10 characters)")
  end
end
