require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user = users(:example)
  end

  test "invalid_login" do
  		get login_path
  		assert_template 'sessions/new'
  		post login_path, params: { session: { mob: "4561237",
  												password: "sgs"
  		}}
  		assert_not flash.empty?
  end

  test "valid_login" do
  	get login_path
  	assert_template 'sessions/new'
  	post login_path, params: { session: { mob: "8056180462",
  												password: 'prad2345'}}
    #assert is_logged_in?
    #assert_redirected_to 'users/show' 
    #follow_redirect!
    #assert_template 'users/show'
    #  assert_select 'a[href]=?', login_path, count: 0
     #   assert_select 'a[href]=?', edit_user_path
    #assert_select 'a[href]=?', logout_path
    #delete logout_path
    #assert_not is_logged_in?
    #assert_redirected_to root_url


  end

end
