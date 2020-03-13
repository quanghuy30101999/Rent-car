require "test_helper"

class CarsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @car = cars(:two)
  end

  test "should redirect create when not logged in" do
    assert_no_difference "Car.count" do
      post cars_path, params: { car: { name: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference "Car.count" do
      delete car_path(@car)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong car" do
    log_in_as(users(:michael))
    car = cars(:one)
    assert_no_difference "Car.count" do
      delete car_path(car)
    end
    assert_redirected_to root_url
  end

  test "create car successed" do
    log_in_as(users(:michael))
    assert_difference "Car.count" do
      post cars_path, params: { car: { name: "Lorem ipsum",
                                      year: "1990",
                                      color: "red",
                                      price: 1000 } }
    end
    assert_redirected_to @user
    follow_redirect!
    assert_not flash.empty?
  end

  test "create car unsuccessed" do
    log_in_as(users(:michael))
    assert_no_difference "Car.count" do
      post cars_path, params: { car: { name: "",
                                      year: "1990",
                                      color: "red",
                                      price: 100 } }
    end
    assert_template "users/show"
  end

  test "Destroy successed" do
    log_in_as(users(:michael))
    assert_difference "Car.count", -1 do
      delete car_path(@car)
    end
    assert_redirected_to @user
    assert_not flash.empty?
  end

  test "edit successed" do
    log_in_as(users(:michael))
    assert_no_difference "Car.count" do
      get edit_car_path(@car)
    end
  end

  test "update successed" do
    log_in_as(users(:michael))
    assert_no_difference "Car.count" do
      get edit_car_path(@car)
      patch car_path, params: { car: { name: "OK",
                                      year: "1999",
                                      color: "blue",
                                      price: 1000 } }
    end
    assert_redirected_to @user
    assert_not flash.empty?
  end

  test "update unsuccessed" do
    log_in_as(users(:michael))
    assert_no_difference "Car.count" do
      get edit_car_path(@car)
      patch car_path, params: { car: { name: "",
                                      year: "1999",
                                      color: "blue",
                                      price: 1000 } }
    end
    assert_template "edit"
  end
end
