class MapPageController < ApplicationController
  include ActionController::Live

  def index
  end

  def stream_tweets
    return unless params[:list_query].present?
    response.headers['Content-Type'] = 'text/event-stream'
    sse = SSE.new(response.stream, retry: 300, event: "tweet")
    begin
      client = TwitterClient.new
      client.streaming(params[:list_query]) do |tweet|
        tweet = client.oembed(tweet.id).html if tweet.is_a?(Twitter::Tweet)
        t = render_to_string(partial: 'map_page/stream_tweets.html.erb', locals: {tweet: tweet})
        sse.write (t)
      end
    rescue IOError
      # Client Disconnected
    ensure
      sse.close
    end
    render nothing: true
  end

  def stream_tweets2
    stream_tweets
  end

  private

  def search_params
    params.require(:list_query)
  end
end
