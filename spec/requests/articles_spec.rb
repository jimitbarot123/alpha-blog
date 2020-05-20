require 'rails_helper'

RSpec.describe "Articles", type: :request do

  before do
    @john = User.create(email: "john@example.com", password: "password")
    @fred = User.create(email: "fred@example.com", password: "password")
    @article = Article.create!(title: "Title One", description: "Description of article one", user: @john)
  end

  describe 'GET /articles/:id/edit' do
    context 'with non-signed in user' do
      before { get "/articles/#{@article.id}/edit" }

      it "redirects to the signin page" do
        expect(response.status).to eq 302
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user who is non-owner' do
      before do
        login_as(@fred)
        get "/articles/#{@article.id}/edit"
      end

      it "redirects to the home page" do
        expect(response.status).to eq 302
        flash_message = "You are not authorized to access this page."
        expect(flash[:alert]).to eq flash_message
      end
    end
  end

  describe 'GET /articles/:id' do
    context 'with existing article' do
      login_as(@john)
      before do
         login_as(@john) # login as john/fred, both case will work properly
         get "/articles/#{@article.id}"
      end

      it "handles existing article" do
        expect(response.status).to eq 200
      end
    end

    context 'with non-existing article' do
      #before { get "/articles/100" }
      before do
        login_as(@john)
        get "/articles/100"
      end

      it "handles non-existing article" do
        expect(response.status).to eq 302
        flash_message = "The article you are looking for could not be found"
        expect(flash[:alert]).to eq flash_message
      end
    end
  end
end
