module PostsHelper
  FB_PAGE_ID = "336926053091417"
  FB_TOKEN = "AAAG8YOiNydQBADF2ZC5GWk21tuhlyZA8OAF0cyDmoj7SRYj4U01zlz3lkEe1qGuUlZBYJv6lxCObcIzVeSXZCd6swNtc5iW7GSHCdHzTxJfdd8RuUWCO"

  
  def tweet(post)
    Twitter.configure do |config|
      config.consumer_key = APP_CONFIG['twitter_consumer_key']
      config.consumer_secret = APP_CONFIG['twitter_consumer_secret']
      config.oauth_token = APP_CONFIG['twitter_access_token']
      config.oauth_token_secret = APP_CONFIG['twitter_secret_token']
    end    
    shorted_url = shorten_url(single_url(hash: post.permalink))
    Twitter.update("#{post.title} - #{shorted_url}")
  end
  
  #post
  def facebook_post(post)
  
    owner = FbGraph::User.me(FB_TOKEN)
    
    pages = owner.accounts
    
    #Searches for the correct page
    page = pages.detect do |page|
      page.identifier == FB_PAGE_ID
    end
    
    page.feed!(
      :message => "Resignako.com message!",
      :description => post.entry,
      :link => single_url(hash: post.permalink)
    )
  end
  
  def social_push(queue_item=nil) 
    if queue_item == nil
      #get the first item from the queue
      queue_item = PostQueue.where(:pushed => FALSE).first
    end
    
    #DO FACEBOOK HERE
    #facebook_post queue_item.post
    #tweet()
    
    queue_item.pushed = TRUE
    queue_item.save
  end
  
end
