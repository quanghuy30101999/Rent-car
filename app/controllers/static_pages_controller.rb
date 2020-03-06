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
    if params[:search].blank?
      redirect_to(root_path, alert: "Empty field!") and return
    else
      @parameter = params[:search].downcase
      @results = Car.all.where("lower(name) LIKE :search OR namsx LIKE :search", search: "%#{@parameter}%")
    end
  end
end
