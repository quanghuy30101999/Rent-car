class CarsController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  before_action :correct_user, only: [:destroy, :update, :edit]

  def index
    @car = Car.all
    @parameter = params[:search].downcase
    @parameter1 = params[:search].to_i
    @car = @car.where("lower(name) LIKE :search OR year LIKE :search OR color LIKE :search", search: "%#{@parameter}%") if params[:search].present?
    #@car = @car.where("color LIKE :search", search: "%#{@parameter}%") if params[:search].present?
    d = params[:search2].to_datetime
    @b = @car.where("begin IS NULL") if params[:search1].present? && params[:search2].present?
    @c = @car.where("status = '#{"rented"}'") if params[:search1].present? && params[:search2].present?
    a = params[:search1].to_datetime
    @c = @c.where("cars.end > ?", d)
    @b += @c
    @car = @b
    @feed_items = @car
    render "static_pages/home"
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
