require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  def setup
    # @user = users(:michael)
    @car = cars(:two)
    @order = orders(:one)
  end

  test "login admin test index if params blank" do
    log_in_as(users(:michael))
    get orders_path
    assert_select ".address", 2
  end

  test "login not admin test index if params blank" do
    @user = users(:michael1)
    log_in_as(@user)
    get orders_path
    assert_select ".address", 2
  end
end
