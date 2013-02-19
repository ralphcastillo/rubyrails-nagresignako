class PostsController < ApplicationController  
  def hot
    @page = params[:page] ? Integer(params[:page]) : 0
    
    @posts = Post.find(:all)
    check_if_ajax 
  end

  def new
    @page = params[:page] ? Integer(params[:page]) : 0
    # @posts = Post.find(:all)
    @posts = Post.where("verified = ?", true)
    check_if_ajax 
  end
  
  def top_good
    @page = params[:page] ? Integer(params[:page]) : 0
    @posts = Post.find(:all)
    check_if_ajax 
  end
  
  def top_bad
    @page = params[:page] ? Integer(params[:page]) : 0
    @posts = Post.find(:all)
    check_if_ajax 
  end

  def create
    @post = Post.new(params[:post])
    
    @via = params[:via]
    if @via == 'fb'
      
        if @post.save
          session[:post_id] = @post.id
          redirect_to client.authorization.authorize_url(:redirect_uri => "http://localhost:3000/posts/callback/" ,
      :client_id => '366867723400168',:scope => 'email')
        else
          respond_to do |format|
          format.html  { render :action => "submit" }
          format.json  { render :json => @post.errors,
                      :status => :unprocessable_entity }
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
          UserMailer.verify_user(@user, @post).deliver        
          flash[:notice] = 'Please check your mail to verify your post. Thank you for posting.'
          format.html  { redirect_to :action => "new" } 
        else
          format.html  { render :action => "submit" }
          format.json  { render :json => @post.errors,
                      :status => :unprocessable_entity }
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
    #check_if_ajax
    @post = Post.find(params[:id])
    @unique = "This-is-a-placeholder"
    
    @post_vote = PostsVote.find(:all, :conditions => ["post_id = #{@post.id}", "unique_identifier=#{@unique}"], :limit => 1)
    
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
    else
      PostsVote.create(post_id: params[:id], unique_identifier: @unique, vote_good: TRUE, vote_bad: FALSE)
      @post.total_good = @post.total_good + 1
      @post.total_tally = @post.total_tally + 1
      
      @post.save
      
    end
#    @post.total_good++
  end

  def vote_down
    @post = Post.find(params[:id])
    @unique = "This-is-a-placeholder"
    
    @post_vote = PostsVote.find(:all, :conditions => ["post_id = #{@post.id}", "unique_identifier=#{@unique}"], :limit => 1)
    
    if @post_vote[0] != nil
      _postvote = @post_vote.first
      
      if _postvote.vote_good
        _postvote.vote_good = FALSE
        _postvote.vote_bad = TRUE
        _postvote.save
        
        @post.total_bad = @post.total_good + 1
        @post.total_good = @post.total_bad - 1
        
        @post.save
      end
    else
      PostsVote.create(post_id: params[:id], unique_identifier: @unique, vote_bad: TRUE, vote_good: FALSE)
      @post.total_bad = @post.total_bad + 1
      @post.total_tally = @post.total_tally + 1
      
      @post.save
      
    end
  end

  def report
  end
  
  def single
    if defined? params[:hash]
      @content = "This is a sample content!";
      @hash = params[:hash]
      
      @posts = Post.where("permalink = ?", @hash)
      if @posts.count > 0
        @post = @posts[0]
        @user = User.find(@post.user_id)
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
    redirect_to client.authorization.authorize_url(:redirect_uri => "http://localhost:3000/posts/callback/" ,
      :client_id => '366867723400168',:scope => 'email')
  end
  
  def callback
    @access_token = client.authorization.process_callback(params[:code], :redirect_uri => "http://localhost:3000/posts/callback/")
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
        flash[:notice] = 'Thank you for posting.'
        format.html  { redirect_to :action => "new" } 
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
