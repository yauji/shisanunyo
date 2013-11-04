require 'test_helper'

class PerformancesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    # @base_issue = base_issues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_equal 100, assigns(:principal)
    assert_equal 200, assigns(:value)
    # assert_not_nil assigns(:principal)
  end

end
