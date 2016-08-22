class TwitterClient
  CLIENT = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
    config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
    config.access_token = ENV['TWITTER_ACCESS_TOKEN']
    config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
  end

  attr_reader :client
  attr_accessor :last_tweet_id

  def initialize
    @client = CLIENT
  end

  def last_id
    @last_tweet_id
  end

  def perform_search(query,last_tweet_id)
    begin
      tweets, tweets_ids = []

      options = {
        result_type: 'recent',
        count: 25
      }
      options.merge!(since_id: last_tweet_id) if last_tweet_id.present?
      tweets_ids = client.search(query, options).take(10).map(&:id)
      @last_tweet_id = tweets_ids.last
      tweets = client.oembeds(tweets_ids, :align => 'center').map(&:html)
      tweets
    rescue Twitter::Error::TooManyRequests => error
      sleep error.rate_limit.reset_in + 1
      retry
    rescue => error
      puts error.inspect
    end
  end
end
