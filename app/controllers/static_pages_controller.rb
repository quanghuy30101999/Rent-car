class StaticPagesController < ApplicationController
  def home
    @cars = Car.all
  end
end
