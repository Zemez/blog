class HomeController < ApplicationController
  def index
  end
  def about
  end
  def test
    Rails.logger.info '#########################################'
    Rails.logger.info params.inspect
    Rails.logger.info '#########################################'
  end
end
