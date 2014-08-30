require 'test_helper'

class PerformancesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    # @base_issue = base_issues(:one)
    user = 'yoji'
    pw = 'oza'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_equal 46000, assigns(:principal)
    assert_equal 240338.4, assigns(:value)
    # assert_not_nil assigns(:principal)
  end

end
