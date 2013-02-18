class PostsController < ApplicationController  
  def hot
    @posts = Post.find(:all)
    check_if_ajax 
  end

  def new
    @posts = Post.find(:all)
    check_if_ajax 
  end
  
  def top_good
    @posts = Post.find(:all)
    check_if_ajax 
  end
  
  def top_bad
    @posts = Post.find(:all)
    check_if_ajax 
  end

  def create
    @post = Post.new(params[:post])
    
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
  
  def verify
    @posts = Post.where("permalink = ?", params[:permalink])
    
    respond_to do |format|
      if @posts.count > 0
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
  end

  def vote_down
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
   
    flash[:notice] = 'Thank you for posting.'
    redirect_to :action => "new"
  end
end
