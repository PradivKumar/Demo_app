require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "signup test" do
  	get signup_path
  	assert_no_difference 'User.count' do
  		post users_path, params: {user: {name: "",
  										mob: "sfdg",
  										password: "foo",
  										password_confirmation: "bar"}}
  	end
  	assert_template 'users/new'
  	assert_select 'div#error_explanation'
  	assert_select 'div.field_with_errors'
  end

  test "valid_signup" do
  	get signup_path
  	assert_difference 'User.count', 1 do
  		post users_path, params: {user: {name: "Username",
  									mob: "9840000000",
  									password: "userpass",
  									password_confirmation: "userpass"}}
  	end
  	#assert_template 'users/index'

  end


end
