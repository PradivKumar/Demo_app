require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
 def setup
 	@relationship = Relationship.new(follower_id: users(:example).id, followed_id: users(:pradiv).id)
 	
 end

  test "should be valid" do
  	assert @relationship.valid?
  end

  test "follower should be present" do
  	@relationship.follower_id = nil
  	assert_not @relationship.valid?
  end

test "followed should be present" do
  	@relationship.followed_id = nil
  	assert_not @relationship.valid?
  end  

end
