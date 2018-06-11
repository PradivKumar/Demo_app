require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

def setup
	@basetitle = "ROR"
	@user = users(:example)
	@second_user = users(:pradiv)
end

  test "should get index" do
  	get index_path
  	assert_response :success
  	assert_select "title",  "Index | #{@basetitle}"
  end
  test "redirect when not logged in" do
  	get edit_user_path(@user)
  	assert_not flash.empty?
  	assert_redirected_to login_path
  end

=begin
  test "redirect destroy when logged in as non admin" do
    log_in_as(@second_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_path
  end
=end

end
