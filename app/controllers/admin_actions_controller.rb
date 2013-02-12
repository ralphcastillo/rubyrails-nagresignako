class AdminActionsController < ApplicationController
  layout "admin_base"
  def add_seed
      
      @post = Post.new
  end
  
  def create_seed
    
      @user = User.find_by_email (current_admin.email)
    
      if (@user == nil) 
        @user = User.create({ email: current_admin.email })
      end
    
    @post = Post.new(params[:post])
    @post.user_id = @user.id
    @post.verified = TRUE
    @post.save

    @post = Post.new
    flash.now[:success] = "Seed content successfully added!"
    render 'add_seed'
  end

  def manage_posts
    #TODO: PAGINATE THIS BITCH
    id ||= params[:id]
    action  ||= params[:task]
    
    if request.get?
      @posts = Post.all
      #where reported_spam < 10
    elsif request.post?
      _post = Post.find(id)
      
      if _post == nil
        redirect_to admin_actions_manage_posts_path
      end
      
      if (action == "hide")
        _post.reported_spam += 10
        _post.save
        
        flash.now[:success] = "Post id #{_post.id} has been marked as spam."
      end
      
      @posts = Post.all
      render 'manage_posts'
    elsif request.delete?
      _post = Post.find(id) #catch null
      
      if _post == nil
        redirect_to admin_actions_manage_posts_path
      end
      
      _post.destroy
      
      flash.now[:success] = "Post id #{_post.id} has been deleted."
      
      @posts = Post.all
      render 'manage_posts'
    end
  end

  def manage_spam
    task = params[:task] || nil
    
    if request.get?
      @posts =     Post.find(:all, :conditions => ["reported_spam > 0"])
    elsif request.post? && task=="show" #post is not a spam
      _post = Post.find(params[:id])
      _post.reported_spam = 0
      _post.save
      
      flash.now[:success] = "Successfully removed spam status of entry id #{_post.id}"
      
      @posts =     Post.find(:all, :conditions => ["reported_spam > 0"])
      render 'manage_spam'
    elsif request.delete? && task=="delete"
      _post = Post.find(params[:id])
      _post.destroy
      
      flash.now[:success] = "Successfully deleted spam from database"
      @posts =     Post.find(:all, :conditions => ["reported_spam > 0"])
      render 'manage_spam'
    end
      
  end

  def facebook_push
  end

  def twitter_push
  end
  
end