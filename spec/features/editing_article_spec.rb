require 'rails_helper'

RSpec.feature "Editing an article" do

  let(:dhaval) { User.create!(username: "testuser", email: "test@example.com", password: "password")}

  feature "User with have admin access" do
    before do
      @article = Article.create(title: "The first article", description: "Description of 1st article")
      user = User.create!(username: "testuser", email: "test@example.com", password: "password", superadmin_role: true)
      login_as(user)
    end

    scenario "A user updates an article" do
      visit "/"
      click_link "Edit"

      fill_in "title", with: "Updated Title"
      fill_in "description", with: "Updated description of Article"
      click_button "Update Article"

      expect(page).to have_content("Article was updated successfully.")
      expect(page).to have_content("Updated Title")
      expect(page).to have_content("Updated description of Article")
      expect(page).to have_current_path(article_path(@article))
    end

    scenario "A user updates an article in a diff way" do
      visit "/"
      click_link @article.title
      click_link "Edit"

      fill_in "title", with: "Updated Title"
      fill_in "description", with: "Updated description of Article"
      click_button "Update Article"

      expect(page).to have_content("Article was updated successfully.")
      expect(page).to have_content("Updated Title")
      expect(page).to have_content("Updated description of Article")
      expect(page).to have_current_path(article_path(@article))
    end

    scenario "A user fails to update an article" do
      visit "/"
      click_link "Edit"

      fill_in "title", with: ""
      fill_in "description", with: "Updated description of Article"
      click_button "Update Article"

      expect(page).to have_content("Title can't be blank")
      expect(page).to have_current_path(article_path(@article))
    end

  end

  feature "User with no any admin access" do
    before do
      @article = Article.create(title: "The first article", description: "Description of 1st article")
      # below admin user is created just because of associate it with above created article only
      user = User.create!(username: "testuser", email: "test2@example.com", password: "password", superadmin_role: true)
    end

    scenario "A user fails to update an article" do
      login_as(dhaval)
      visit "/"

      expect(page).to have_link("View")
      expect(page).not_to have_link("Edit")
    end

    scenario "A user fails to update an article in diff way" do
      login_as(dhaval)
      visit "/"
      click_link @article.title

      expect(page).not_to have_link("Edit")
    end
  end


end
