require 'test_helper'

class SitelayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "layout_links" do
  	get index_path
  	assert_select "a[href=?]", index_path, count: 2
  end

end
