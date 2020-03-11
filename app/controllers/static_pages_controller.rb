class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @car  = current_user.cars.build
      @feed_items = current_user.feed
    else
      @feed_items = seach_admin.feed
    end
  end
end
