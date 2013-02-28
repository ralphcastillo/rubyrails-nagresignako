class PostsController < ApplicationController  
  def hot    
    @page = params[:page] ? Integer(params[:page]) : 0
    @post_count = params[:post_count] ? Integer(params[:post_count]) : 0
    @total_count = Post.find(:all, :conditions => { :verified => true }).length
    if (@post_count) < @total_count
    @posts = Post.find(:all, :conditions => { :verified => true }, :offset => @post_count, :limit => 10, :order => 'total_tally desc')
    
    @post_votes_bad = PostsVote.find(:all, :conditions => { :unique_identifier => cookies[:unique_resignako_id], :vote_bad => true })
    @post_votes_good = PostsVote.find(:all, :conditions => { :unique_identifier => cookies[:unique_resignako_id], :vote_good => true })
    @post_votes_spam = PostsVote.find(:all, :conditions => { :unique_identifier => cookies[:unique_resignako_id], :set_spam => true })
    
    @display = true
    else
    @display = false
    end
    check_if_ajax 
  end

  def new
    @page = params[:page] ? Integer(params[:page]) : 0
    @post_count = params[:post_count] ? Integer(params[:post_count]) : 0
    @total_count = Post.find(:all, :conditions => { :verified => true }).length
    if (@post_count) < @total_count
    @posts = Post.find(:all, :conditions => { :verified => true }, :offset => @post_count, :limit => 10, :order => 'id desc')
    
    @post_votes_bad = PostsVote.find(:all, :conditions => { :unique_identifier => cookies[:unique_resignako_id], :vote_bad => true })
    @post_votes_good = PostsVote.find(:all, :conditions => { :unique_identifier => cookies[:unique_resignako_id], :vote_good => true })
    @post_votes_spam = PostsVote.find(:all, :conditions => { :unique_identifier => cookies[:unique_resignako_id], :set_spam => true })
    
    @display = true
    else
    @display = false
    end
    check_if_ajax 
  end
  
  def top_good
    @page = params[:page] ? Integer(params[:page]) : 0
    @post_count = params[:post_count] ? Integer(params[:post_count]) : 0
    @total_count = Post.find(:all, :conditions => { :verified => true }).length
    if (@post_count) < @total_count
    @posts = Post.find(:all, :conditions => { :verified => true }, :offset => @post_count, :limit => 10, :order => 'total_good desc')
    
    @post_votes_bad = PostsVote.find(:all, :conditions => { :unique_identifier => cookies[:unique_resignako_id], :vote_bad => true })
    @post_votes_good = PostsVote.find(:all, :conditions => { :unique_identifier => cookies[:unique_resignako_id], :vote_good => true })
    @post_votes_spam = PostsVote.find(:all, :conditions => { :unique_identifier => cookies[:unique_resignako_id], :set_spam => true })
    
    @display = true
    else
    @display = false
    end
    check_if_ajax
  end
  
  def top_bad    
    @page = params[:page] ? Integer(params[:page]) : 0
    @post_count = params[:post_count] ? Integer(params[:post_count]) : 0
    @total_count = Post.find(:all, :conditions => { :verified => true }).length
    if (@post_count) < @total_count
    @posts = Post.find(:all, :conditions => { :verified => true }, :offset => @post_count, :limit => 10, :order => 'total_bad desc')
    
    @post_votes_bad = PostsVote.find(:all, :conditions => { :unique_identifier => cookies[:unique_resignako_id], :vote_bad => true })
    @post_votes_good = PostsVote.find(:all, :conditions => { :unique_identifier => cookies[:unique_resignako_id], :vote_good => true })
    @post_votes_spam = PostsVote.find(:all, :conditions => { :unique_identifier => cookies[:unique_resignako_id], :set_spam => true })
    
    @display = true
    else
    @display = false
    end
    check_if_ajax
  end

   def create
    @post = Post.new(params[:post])

    @via = params[:via]
    if @via == 'fb'

      if @post.save
        session[:post_id] = @post.id
        redirect_to client.authorization.authorize_url(:redirect_uri => "http://#{request.host_with_port}/posts/callback/" ,
      :client_id => '488599381199316',:scope => 'email')
      else
        respond_to do |format|
          flash[:error] = @post.errors
          format.html  { redirect_to :action => "submit" }
        end
      end

    else
      @users = User.where("email = ?", params[:email])

      if @users.count < 1
        @user = User.new
        @user.email = params[:email]
      @user.save
      else
        @user = @users[0]
      end

      @post.user_id = @user.id
      @post.permalink = Digest::MD5.hexdigest(@user.email + '' + Date.today.to_formatted_s(:db))

      respond_to do |format|
        if @post.save
          UserMailer.verify_user(@user, @post, "http://#{request.host_with_port}/posts/verify").deliver
          flash[:notice] = "Verification email sent. This post will be visible upon verification. Go to #{view_context.link_to('Homepage', new_path)}".html_safe
          format.html  { redirect_to :action => "new" }
          # format.html  { redirect_to :action => "single", :hash => @post.permalink }
        else
          flash[:error] = @post.errors
          format.html  { redirect_to :action => "submit" }
        end
      end
    end
  end
  
  def verify
    @posts = Post.where("permalink = ?", params[:permalink])
    
    respond_to do |format|
      if @posts.count > 0
        @posts[0].verified = true
        @posts[0].save
        flash[:notice] = 'Thank you for posting. Go to <a href="/">Homepage</a>.'
        format.html  { redirect_to :action => "single", :hash => @posts[0].permalink }
      else
        not_found
      end
    end
  end

  def submit
    @post = Post.new
  end

  def vote_up
    @post = Post.find(params[:id])
    @unique = "#{request.remote_ip}"
    
    @post_vote = PostsVote.where("post_id = ? AND unique_identifier = ? AND vote_good is not NULL AND vote_bad is not NULL", @post.id, @unique).limit(1)
    
    if @post_vote[0] != nil
      _postvote = @post_vote.first
      
      if _postvote.vote_bad
        _postvote.vote_bad = FALSE
        _postvote.vote_good = TRUE
        _postvote.save
        
        @post.total_good = @post.total_good + 1
        @post.total_bad = @post.total_bad - 1
        
        @post.save
      end
      
      @target_post_vote = _postvote
    else
      @target_post_vote = PostsVote.create(post_id: params[:id], unique_identifier: @unique, vote_good: TRUE, vote_bad: FALSE)
      @post.total_good = @post.total_good + 1
      @post.total_tally = @post.total_tally + 1
      cookies[:unique_resignako_id] = @unique
      
      @post.save
      
    end

    check_if_ajax
  end

  def update_vote_up
    @unique = "#{request.remote_ip}"
    @post = Post.find(params[:id])
    @target_post_vote = PostsVote.where("post_id = ? AND unique_identifier = ? ", @post.id, @unique).limit(1).first
    
    check_if_ajax
  end
  
  def update_vote_down
    @unique = "#{request.remote_ip}"
    @post = Post.find(params[:id])
    @target_post_vote = PostsVote.where("post_id = ? AND unique_identifier = ? ", @post.id, @unique).limit(1).first
    
    check_if_ajax
  end

  def vote_down
    @post = Post.find(params[:id])
    @unique = "#{request.remote_ip}"
    
    @post_vote = PostsVote.where("post_id = ? AND unique_identifier = ? AND vote_good is not NULL AND vote_bad is not NULL", @post.id, @unique).limit(1)
    
    if @post_vote[0] != nil
      _postvote = @post_vote.first
      
      if _postvote.vote_good
        _postvote.vote_good = FALSE
        _postvote.vote_bad = TRUE
        _postvote.save
        
        @post.total_bad = @post.total_bad + 1
        @post.total_good = @post.total_good - 1
        
        @post.save
      end
      
      @target_post_vote = _postvote
    else
      @target_post_vote = PostsVote.create(post_id: params[:id], unique_identifier: @unique, vote_bad: TRUE, vote_good: FALSE)
      @post.total_bad = @post.total_bad + 1
      @post.total_tally = @post.total_tally + 1
      cookies[:unique_resignako_id] = @unique
      
      @post.save
      
    end
    
    check_if_ajax
  end

  def report
    @post = Post.find(params[:id])
    @unique = "#{request.remote_ip}"
    
    @post_vote = PostsVote.find(:all, :conditions => { :post_id => @post.id, :unique_identifier => @unique, :set_spam => true }, :limit => 1)
    
    if @post_vote[0] == nil
      PostsVote.create(post_id: params[:id], unique_identifier: @unique, set_spam: TRUE)
      @post.reported_spam = @post.reported_spam + 1
      cookies[:unique_resignako_id] = @unique
      
      @post.save
    end
  end
  
  def single
    if params[:hash]
      @hash = params[:hash]
      
      @posts = Post.where("permalink LIKE ?", @hash)
      if @posts.count > 0
        @post = @posts[0]
        #@user = User.find(@post.user_id)
      else
        not_found
      end
    else
      not_found
    end
  end
  
  def check_if_ajax 
    @is_ajax = false
    if request.xhr?
      @is_ajax = true
      render :layout => false
    end  
  end
  
  def fb_verify    
    redirect_to client.authorization.authorize_url(:redirect_uri => "http://#{request.host_with_port}/posts/callback/" ,
      :client_id => '488599381199316',:scope => 'email')
  end
  
  def callback
    @access_token = client.authorization.process_callback(params[:code], :redirect_uri => "http://#{request.host_with_port}/posts/callback/")
    session[:access_token] = @access_token
    @fb_user = client.selection.me.info!
   
    @post = Post.find(session[:post_id])
    @users = User.where("email = ?", @fb_user[:email])
    
    if @users.count < 1
      @user = User.new
      @user.email = @fb_user[:email]
      @user.save
    else
      @user = @users[0]
    end
    
    @post.user_id = @user.id
    @post.permalink = Digest::MD5.hexdigest(@user.email + '' + Date.today.to_formatted_s(:db))
    @post.verified = true
    
    respond_to do |format|
      if @post.save        
        flash[:notice] = 'Thank you for posting. Go to <a href="/">Homepage</a>.'
        format.html  { redirect_to :action => "single", :hash => @post.permalink } 
      else
        format.html  { render :action => "submit" }
        format.json  { render :json => @post.errors,
                    :status => :unprocessable_entity }
      end
    end
  end

  def feed
  end
end
