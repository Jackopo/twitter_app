class HomeController < ApplicationController


  def index
    @tweets = TwitterClient.search_tweets(search_params[:q]) if params[:q].present?
  end

  private

  def search_params
    params.permit(:q)
  end
end
