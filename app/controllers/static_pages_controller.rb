class StaticPagesController < ApplicationController
  def home
    @feed_items = Car.all
  end
end
