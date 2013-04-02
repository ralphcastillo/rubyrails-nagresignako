module PostsHelper
  require 'fileutils' 
  
  FB_PAGE_ID = "336926053091417"
#  FB_TOKEN = "AAAG8YOiNydQBAKj8e6wi7KCFHalHBrr6gm01Qc4PEZBrr1YqErz1HlnVM17XMrqVovfcWMUClV31PBusDhC5BNJqcj5em7XEEQZC1WZAgZDZD"

#PAGE ACCESS TOKEN :
  FB_TOKEN = "AAAG8YOiNydQBAATdVMoZAO9Ffoe2T0ad9S3LlpUzA8pd3KBXuqrb0NJhvdAfP7otUOg5YWEPa3Lk7bG9feVcZAKLwMO2crYBWr2ng2ifEUnqHDAcL7SaGOjVvfbAcZD"
  FB_APP_ID = "488599381199316"
  FB_APPLICATION_SECRET = "572a38ed645c0b275a2ca541ac98bc3d"
  
  
  TWITTER_CONSUMER_KEY = "ZwZLZhbZHTFvHX7IdLXnQ"
  TWITTER_SECRET_KEY = "CebPu35efOX59xD1U4LCdd8oq4l0jUagnA5QVNAM"
  TWITTER_ACCESS_TOKEN = "1181218364-YnwNxrsuJ554CpL1cn3PuWUpbZTck2PBNDwhRo5"
  TWITTER_ACCESS_TOKEN_SECRET = "tnX9yYN0BrpdvLUCFRH9uyBKYJXg1s9ze5WW2be728"

  TEMPORARY_OUTLINK = "http://www.nagresignako.com"
  
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
    Twitter.update("#{post.title} - #nagresignako #{link}")
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
    link = url_for(controller: "posts", action: "single", hash: post.permalink)
    owner.feed!(
      :message => "#{post.title} - " + help.truncate(post.entry, :length => 20),
      :description => post.entry,
      :name => post.title,
      :link =>  Rails.env.production? ? url_for(controller: "posts", action: "single", hash: post.permalink) : TEMPORARY_OUTLINK
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
