class HomeController < ApplicationController


  def index
  	@tweets_raw = Twitter.search("#hashtag", :result_type => "recent").results
  	
    @tweets = []   
    
    @tweets_raw.each_with_index do |tweet,i|      
 			@tweets[i] = Twitter.oembed(tweet.id).html  		  	
  	end

    
    return @tweets 

  end
end
