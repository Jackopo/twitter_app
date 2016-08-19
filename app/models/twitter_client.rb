class TwitterClient
  @@client = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
    config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
    config.access_token = ENV['TWITTER_ACCESS_TOKEN']
    config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
  end

  def self.instance
    @@client
  end

  attr_reader :client

  def initialize
    @client = @@client
  end

  def self.search_tweets(query)
    new.perform_search(query)
  end

  def perform_search(query)
    begin
      tweets, tweets_ids = []

      tweets_ids = client.search(query, result_type: 'recent').take(10).map(&:id)

      tweets = client.oembeds(tweets_ids, :omit_script => true, :align => 'center').map(&:html)
      tweets
    rescue Twitter::Error::TooManyRequests => error
      sleep error.rate_limit.reset_in + 1
      retry
    end
  end
end
