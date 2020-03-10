class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @car  = current_user.cars.build
      @feed_items = current_user.feed
    else
      @feed_items = seach_admin.feed
    end
  end

  def help
  end

  def index
    a = params[:search5].to_i
    @feed = []
    if params[:search].blank? && params[:search5].blank? && params[:search4].blank?
      redirect_to(root_path, alert: "Empty field!") and return
    elsif !params[:search5].blank? && !params[:search4].blank?
      Car.all.each do |car|
        if car.check == false
          @feed.push(car)
        else
          if car.NgayThue.day >= params[:search4].to_i
            @feed.push(car)
          end
        end
      end
    else
      @parameter = params[:search].downcase
      @results = Car.all.where("lower(name) LIKE :search OR namsx LIKE :search", search: "%#{@parameter}%")
    end
  end

  private
  def feed
    Car.where("user_id = ?", id)
  end
end