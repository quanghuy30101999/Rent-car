require "test_helper"

class CarTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @car = @user.cars.build(name: "Lorem ipsum", year: "1990", color: "red", price: 1000, user_id: @user.id)
  end

  test "should be valid" do
    assert @car.valid?
  end

  test "user id should be present" do
    @car.user_id = nil
    assert_not @car.valid?
  end

  test "Money does not accept characters" do
    @car.price = "abc"
    assert_not @car.valid?
  end

  test "name should be present" do
    @car.name = "   "
    assert_not @car.valid?
  end

  test "name should be at most 50 characters" do
    @car.name = "a" * 51
    assert_not @car.valid?
  end
end
