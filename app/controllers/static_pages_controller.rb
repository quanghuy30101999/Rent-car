class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @cars  = current_user.cars.build
      @feed_items = current_user.feed
    else
      @feed_items = Car.all
    end
  end
end
