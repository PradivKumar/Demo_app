require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

def setup
	@basetitle = "ROR"
end

  test "should get index" do
  	get index_path
  	assert_response :success
  	assert_select "title",  "Index | #{@basetitle}"
  end
end
