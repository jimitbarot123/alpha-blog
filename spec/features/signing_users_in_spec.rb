require 'rails_helper'

RSpec.feature "Users signin" do
  before do
    @jimit = User.create!(email: "jimit@example.com", password: "password")
  end

  scenario "with valid credentials" do
    visit "/"

    click_link "Log in"
    fill_in "Email", with: @jimit.email
    fill_in "Password", with: @jimit.password
    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Hi, #{@jimit.email}")
    expect(page).not_to have_link("Sign in")
    expect(page).not_to have_link("Sign up")
    expect(page).to have_link("Logout")
    expect(page.current_path).to eq(articles_path)
  end

  scenario "with invalid credentials" do
    visit "/"

    click_link "Log in"
    fill_in "Email", with: 'invalid@example.com'
    fill_in "Password", with: 'password'
    click_button "Log in"

    expect(page).to have_content("Invalid Email or password.")
    expect(page.current_path).to eq(new_user_session_path)

  end
end
