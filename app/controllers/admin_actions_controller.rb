class AdminActionsController < ApplicationController
  layout "admin_base"
  before_filter :redirect_if_loggedout  
  
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

  def manage_queue
    #Order this by datetime

    pushed = params[:pushed] != nil && params[:pushed] == "true"
    
    #TODO make activerecord
    @queue_items = PostQueue.where(pushed: pushed)
    @pushed = pushed
  end
  
  def delete_queue      
      _queue_item = PostQueue.find(params[:id])
      _queue_item.delete
      
      flash.now[:success] = "Deletion of post item from queue successful!"
      redirect_to request.referrer
  end
  
  def force_push
    _queue_item = PostQueue.find(params[:id])

    PostsHelper.social_push _queue_item
    
    flash.now[:success] = "Post item has been pushed successfully!"
    redirect_to request.referrer
  end
  
  def consume_queue
    #PostsHelper
    social_push
    flash.now[:success] = "Queue has been consumed!"
    
    redirect_to request.referrer
    
  end

  
end