class CarsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user,   only: :destroy

  def create
    @cars = current_user.cars.build(car_params)
    if @cars.save
      flash[:success] = "Car created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @cars.destroy
    flash[:success] = "Car deleted"
    redirect_to request.referrer || root_url
  end

  def edit
    @cars = Car.find(params[:id])
  end

  def update
      @cars = Car.find(params[:id])
      if @cars.update(car_params)
        flash[:success] = "Car updated"
        redirect_to root_url
      else
        render 'edit'
      end
  end
  private

    def car_params
      params.require(:car).permit(:name, :year, :color, :price)
    end

    def correct_user
      @cars = current_user.cars.find_by(id: params[:id])
      redirect_to root_url if @car.nil?
    end
end