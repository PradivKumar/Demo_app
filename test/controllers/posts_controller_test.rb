require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end




  test "should login before create" do
  	assert_no_difference 'Post.count' do
  		post posts_path, params: { post: { content: "helloo" } }
  	end
  	assert_redirected_to login_url
   end

   test "should login before destroy" do
   	assert_no_difference 'Post.count' do
   		delete post_path(posts(:one))
   	end
   	assert_redirected_to login_url
   end
  
end
