require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  # setup do
  #   @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
  # end

  test "get new category form and create category" do
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
    sign_in_as(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name: "music" } }
      follow_redirect!
    end
    assert_template 'categories/index'
    assert_match "music", response.body
  end

  # test "invalid category submission results in failure" do
  #   @user2 = User.create(username: "jimit", email: "jimit@example.com", password: "password2", admin: true)
  #   sign_in_as(@user2, "password2")
  #   get new_category_path
  #   assert_template 'categories/new'
  #   assert_no_difference 'Category.count' do
  #     post categories_path, params: { category: { name: " " } }
  #     #follow_redirect!
  #   end
  #   assert_template 'categories/new'
  #   assert_select 'h4.alert-heading'
  # end

  test "should redirect create when admin not logged in" do
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: "sports" } }
    end
    assert_redirected_to categories_path
  end

end
