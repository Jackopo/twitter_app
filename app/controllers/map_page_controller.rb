class MapPageController < ApplicationController
  include ActionController::Live

  def index

  end

  def show
    response.headers['Content-Type'] = 'text/event-stream'
    sse = SSE.new(response.stream, retry: 300, event: "tweet-found")
    @tweets = []
    begin
      client = TwitterClient.new
      if params[:list_query].present?
        client.streaming(params[:list_query].join(', ')) do |tweet|
          tweet = client.oembed(tweet.id).html if tweet.is_a?(Twitter::Tweet)
          sse.write ({ :tweets => tweet })
        end
      end
    rescue IOError
    ensure
      sse.close
    end
  end

  def stream_tweets
  end

  private

  def search_params
    params.require(:list_query)
  end
end
