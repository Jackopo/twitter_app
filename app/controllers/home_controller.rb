class HomeController < ApplicationController
  @@tweets = []
  def index
  	@tweets_raw = Twitter.search("#diocanes", :result_type => "recent").results
  	@tweets = @@tweets
  	@tweets_raw.each_with_index do |tweet,i|
  		puts "diomerda!"
  		puts @tweets.size
  		
  		puts @tweets[i]

  		if !@tweets.empty? 
  			if @tweets[i] != Twitter.oembed(tweet.id).html 
	  			@tweets[i] = Twitter.oembed(tweet.id).html
	  		end
  		else
  			@tweets[i] = Twitter.oembed(tweet.id).html
  			
  		end  	
  	end

  	return @tweets

  end
end
