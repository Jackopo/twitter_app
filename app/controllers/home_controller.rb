class HomeController < ApplicationController


  def index
    client = TwitterClient.new
    @tweets = client.perform_search(search_params[:q],search_params[:last_tweet_id]) if params[:q].present?
    @last_tweet_id = client.last_id
  end

  def load_tweets
    client = TwitterClient.new
    @tweets = client.perform_search(search_params[:q],search_params[:last_tweet_id]) if params[:q].present?
    @last_tweet_id = client.last_id
    render partial: "home/load_tweets"
  end

  private

  def search_params
    params.permit(:q, :commit, :utf8, :last_tweet_id)
  end
end
