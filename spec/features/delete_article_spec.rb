require 'rails_helper'

RSpec.feature "Deleting an Article" do

  before do
    @article = Article.create(title: "The first article", description: "Description of 1st article")
    @jimit = User.create!(username: "testuser", email: "test@example.com", password: "password", superadmin_role: true)
    login_as(@jimit)
  end

  scenario "A user deletes an article" do
    visit "/"
    click_link @article.title
    click_link "Delete"

    expect(page).to have_content("Article was deleted successfully")
    expect(page).to have_current_path(articles_path)
    expect(Article.count).to eq(0)
  end

  scenario "A user deletes an article with diff way" do
    visit "/"
    click_link "Delete"

    expect(page).to have_content("Article was deleted successfully")
    expect(page).to have_current_path(articles_path)
    expect(Article.count).to eq(0)
  end
end
