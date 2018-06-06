require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "check_login" do
  	get login_path
  	assert_template 'sessions/new'
  	post login_path, params: {session: {mob: "",
  										password: ""}}
  	assert_template 'sessions/new'
  	assert_not flash.empty?
  	

  end
end
