module PostsHelper
  FB_PAGE_ID = "336926053091417"
  FB_TOKEN = "AAAG8YOiNydQBAOWZCvSGhBmqcTEBD03gWKThEkGZCF94sP61ZBzcMsZCjn9q4L5A0uhQPIZAZCX3ZBOcZCoWGmp1PQrNKS8AUkegiR0DwPovbS4TZBchQEagC"
  
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
  
  #post
  def facebook_post()
    logger.info "HELLO"
    logger.debug "DEBUG HeLLO"
    
    owner = FbGraph::User.me(FB_TOKEN)
    pages = owner.accounts
    page = pages.detect do |page|
      page.identifier == FB_PAGE_ID
    end
    
    page.feed!(
      :message => "This is a Sample MESSAGE",
      :description => "THIS IS A SAMPLE DESCRIPTION",
      :link => "http://secret-falls-8426.herokuapp.com")
  end
end
