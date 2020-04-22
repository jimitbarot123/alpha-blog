require 'test_helper'

class ListCategoriesTest  < ActionDispatch::IntegrationTest

  def setup
    @category = Category.create(name: "travel")
    @category2 = Category.create(name: "programming")
  end

end
