require "rails_helper"

RSpec.feature "Listing Articles" do

  before do
    @article1 = Article.create(title: "The first article", description: "Description of 1st article")
    @article2 = Article.create(title: "The second article", description: "Description of 2nd article")

    @jimit = User.create!(username: "testuser", email: "test@example.com", password: "password", superadmin_role: true)
    login_as(@jimit)
  end

  scenario "A user lists all articles" do
    visit "/"

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.description)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.description)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)

  end
  
end
