require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@user = users(:example)
  	@post = @user.posts.new(content: "Hello")
  end

  test "check presence of content" do
  	@post.content = nil
  	assert_not @post.valid?
  end

  test "check presence of user_id" do
  	@post.user_id = nil
  	assert_not @post.valid?
  end

  test "check content length" do
  	@post.content = "a"*201
  	assert_not @post.valid?
  end
end
