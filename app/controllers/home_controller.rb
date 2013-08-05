class HomeController < ApplicationController
  @@tweets = []
  def index
  	@tweets_raw = Twitter.search("#diocanes", :result_type => "recent").results
  	
    @size = @@tweets.size
    
    puts @tweets_raw.size.to_s + " - " + @size.to_s

    @tweets_raw.each_with_index do |tweet,i|
      
  		if @@tweets.empty? 
  			@@tweets[i] = Twitter.oembed(tweet.id).html
  		else
  			if @@tweets[i] != Twitter.oembed(tweet.id).html 
	  			@@tweets[i] = Twitter.oembed(tweet.id).html
	  			
	  		end  			
  		end  	
  	end
	
    if @@tweets.size == @size 
      puts 1
      return 
    else
      puts 2
    	@tweets = @@tweets
  	  return @tweets 
    end
  end
end
