require 'test_helper'

class CarsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @car = cars(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Car.count' do
      post cars_path, params: { car: { name: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Car.count' do
      delete car_path(@car)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong car" do
    log_in_as(users(:michael))
    car = cars(:one)
    assert_no_difference 'Car.count' do
      delete car_path(car)
    end
    assert_redirected_to root_url
  end

end
