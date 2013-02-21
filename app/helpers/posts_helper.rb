module PostsHelper
  require 'fileutils' 
  
  FB_PAGE_ID = "336926053091417"
#  FB_TOKEN = "AAAG8YOiNydQBAKj8e6wi7KCFHalHBrr6gm01Qc4PEZBrr1YqErz1HlnVM17XMrqVovfcWMUClV31PBusDhC5BNJqcj5em7XEEQZC1WZAgZDZD"

#PAGE ACCESS TOKEN :
  FB_TOKEN = "AAAG8YOiNydQBAJM5jC910hq8SZBwLmzICxZC2OohZB0cNqy6Y2dOKAKbcnlrxOM3ZAav9EiilBSC5Pxw35JG0TLgwNW7n3FfNZCvSYRIl0ZCP7aRHi9ZAgZC"
  FB_APP_ID = "488599381199316"
  FB_APPLICATION_SECRET = "572a38ed645c0b275a2ca541ac98bc3d"
  
  
  TWITTER_CONSUMER_KEY = "ZwZLZhbZHTFvHX7IdLXnQ"
  TWITTER_SECRET_KEY = "CebPu35efOX59xD1U4LCdd8oq4l0jUagnA5QVNAM"
  TWITTER_ACCESS_TOKEN = "1181218364-YnwNxrsuJ554CpL1cn3PuWUpbZTck2PBNDwhRo5"
  TWITTER_ACCESS_TOKEN_SECRET = "tnX9yYN0BrpdvLUCFRH9uyBKYJXg1s9ze5WW2be728"

  TEMPORARY_OUTLINK = "http://secret-falls-8426.herokuapp.com"
  
  def tweet(post)
    Twitter.configure do |config|
      config.consumer_key = TWITTER_CONSUMER_KEY
      config.consumer_secret = TWITTER_SECRET_KEY
      config.oauth_token = TWITTER_ACCESS_TOKEN
      config.oauth_token_secret = TWITTER_ACCESS_TOKEN_SECRET
    end    
    #shorted_url = shorten_url(single_url(hash: post.permalink))
    #link = single_url(hash: post.permalink)
    
    link = url_for(controller: "posts", action: "single", hash: post.permalink) #Rails.env.production? ? single_url(hash: post.permalink) : TEMPORARY_OUTLINK
    Twitter.update("#{post.title} - #{link}")
  end
  
  #post
  def facebook_post(post)
#    fb_auth = FbGraph::Auth.new(FB_APP_ID, FB_APPLICATION_SECRET)
#    fb_auth.exchange_token! 'short-life-access-token'
#    fb_auth.access_token # => Rack::OAuth2::AccessToken
  
    owner = FbGraph::User.me(FB_TOKEN)
    
#    pages = owner.accounts
    
    #Searches for the correct page
#    page = pages.detect do |page|
#      page.identifier == FB_PAGE_ID
#    end
    # for notes on how to get the FB_TOKEN go to 
    # https://developers.facebook.com/docs/howtos/login/login-as-page/
#    puts single_url(hash: post.permalink)
    owner.feed!(
      :message => "This is a Resignako.com message!",
      :description => post.entry,
      :link => url_for(controller: "posts", action: "single", hash: post.permalink) #Rails.env.production? ? single_url(hash: post.permalink) : TEMPORARY_OUTLINK
    )
  end
  
  def social_push(queue_item=nil) 
    if queue_item == nil
      #get the first item from the queue
      queue_item = PostQueue.where(:pushed => FALSE).first
    end
    
    #DO FACEBOOK HERE
    facebook_post queue_item.post
    tweet queue_item.post
    
    queue_item.pushed = TRUE
    queue_item.save

  end
  
end
