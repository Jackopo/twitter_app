class HomeController < ApplicationController
  

  def index
  	@tweets = Twitter.search("un commento dagli states")

  	return @tweets
  end
end
