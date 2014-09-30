class APIController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :validate_api_key

  def validate_api_key
    head(:bad_requet) if params[:api_key] != ENV['INTERNAL_API_KEY']
  end

  def twitter_client(user)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_API_KEY']
      config.consumer_secret     = ENV['TWITTER_API_SECRET']
      config.access_token        = user.token
      config.access_token_secret = user.secret
    end
  end
end
