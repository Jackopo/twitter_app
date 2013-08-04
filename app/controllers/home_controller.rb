class HomeController < ApplicationController
  

  def index
  	@tweets = Twitter.search("#diocane").results
  	return @tweets
  end
end
