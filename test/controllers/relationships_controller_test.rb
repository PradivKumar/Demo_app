require 'test_helper'

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end



 test "should login before create" do
 	assert_no_difference 'Relationship.count' do
 		post relationships_path
 	end
 	assert_redirected_to login_url
 end

 test "should login before delete" do
 	assert_no_difference 'Relationship.count' do
 		delete relationship_path(relationships(:one))
 	end
 	assert_redirected_to login_url
 end

end
