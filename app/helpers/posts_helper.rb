module PostsHelper
  
  def tweet(url)
    Twitter.configure do |config|
      config.consumer_key = APP_CONFIG['twitter_consumer_key']
      config.consumer_secret = APP_CONFIG['twitter_consumer_secret']
      config.oauth_token = APP_CONFIG['twitter_access_token']
      config.oauth_token_secret = APP_CONFIG['twitter_secret_token']
    end    
    shorted_url = shorten_url(url)
    Twitter.update("#{title} - #{shorted_url}")
  end
end
