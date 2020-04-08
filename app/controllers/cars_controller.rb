class CarsController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  before_action :correct_user, only: [:destroy, :update, :edit]

  def index
    @cars = Car.search(params)
    @feed_items = @cars
    render "static_pages/home"
  end

  def show
    @car = Car.find(params[:id])
  end

  def create
    @car = current_user.cars.build(car_params)
    if @car.save
      flash[:success] = "Car created!"
      redirect_to current_user
    else
      @user = current_user
      @cars = Car.all
      render "users/show"
    end
  end

  def destroy
    @car.destroy
    flash[:success] = "Car deleted"
    redirect_to current_user
  end

  def edit
    @car = Car.find(params[:id])
  end

  def update
    @car = Car.find(params[:id])
    if @car.update(car_params)
      flash[:success] = "Car updated"
      redirect_to current_user
    else
      render "edit"
    end
  end

  private

  def car_params
    params.require(:car).permit(:name, :year, :color, :price, :price_unit)
  end

  def correct_user
    @car = current_user.cars.find_by(id: params[:id])
    redirect_to root_url if @car.nil?
  end
end
