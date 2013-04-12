class AdminActionsController < ApplicationController
  layout "admin_base"
  before_filter :redirect_if_loggedout  

  def index
    redirect_to '/admins'
  end
  
  def add_seed
    @post = Post.new
  end
  
  def edit_seed
    if request.get?
      @post = Post.find(params[:id])
    elsif request.put?
      @post = Post.find(params[:id]) 
      @post.name = params[:post][:name]
      @post.age = params[:post][:age]
      @post.entry = params[:post][:entry]
      @post.former_job = params[:post][:former_job]
      
      if (@post.save)
        redirect_to admin_actions_manage_posts_path, flash: { success: "Seed content successfully edited!" }
      end
    end  
  end 
  def create_seed
    
      @user = User.find_by_email (current_admin.email)
    
      if (@user == nil) 
        @user = User.create({ email: current_admin.email })
      end
    
    @post = Post.new(params[:post]);
    @post.user_id = @user.id
    @post.verified = TRUE
    @post.permalink = Digest::MD5.hexdigest(@user.email + '' + Date.today.to_formatted_s(:db))
    @post.save

    redirect_to request.referer, flash: { success: "Seed content successfully added!" }
  end

  def manage_posts
    #TODO: PAGINATE THIS BITCH
    id ||= params[:id]
    action  ||= params[:task]
    params[:page] = params[:page] ? params[:page] : 0
    
    if request.get?
      @posts = Post.order("id desc").page(params[:page]).per(5)
      #where reported_spam < 10
    elsif request.post?
      _post = Post.find(id)
      
      if _post == nil
        redirect_to admin_actions_manage_posts_path
      end
      
      if (action == "hide")
        _post.reported_spam += 10
        _post.save
        
        redirect_to request.referer, flash: { success: "Post id #{_post.id} has been marked as spam." }
      elsif (action == "queue")
       
        _post.queued = TRUE
        _post.save
        
        PostQueue.create(post: _post, pushed: FALSE)
        redirect_to request.referer, flash: {success: "Post ID #{_post.id} has been added to the Social Push Queue."}
      elsif (action == "unqueue")
        _post.queued = FALSE
        _post.save
        
        _post.post_queue.destroy
        redirect_to request.referer, flash: {success: "Post ID #{_post.id} has been removed from the Social Push Queue."}
      end
      
    elsif request.delete?
      _post = Post.find(id) #catch null
      
      if _post == nil
        redirect_to admin_actions_manage_posts_path
      end
      
      _post.destroy
      
      redirect_to request.referer, flash: { success: "Post id #{_post.id} has been deleted." } 
    end
  end

  def manage_spam
    task = params[:task] || nil
    params[:page] = params[:page] ? params[:page] : 0
    
    if request.get?
      @posts =     Post.where("reported_spam > 0").order("id desc").page(params[:page]).per(5)
    elsif request.post? && task=="show" #post is not a spam
      _post = Post.find(params[:id])
      _post.reported_spam = 0
      _post.save
      
      
      @posts =     Post.where("reported_spam > 0").page(params[:page]).per(5)
      
      redirect_to request.referer, flash: { success: "Successfully removed spam status of entry id #{_post.id}" }
      
    elsif request.delete? && task=="delete"
      _post = Post.find(params[:id])
      _post.destroy
      
      @posts =     Post.where("reported_spam > 0").page(params[:page]).per(5)
      redirect_to request.referer, flash: { success: "Successfully deleted spam from database"}
    end
      
  end

  def manage_queue
    #Order this by datetime

    pushed = params[:pushed] != nil && params[:pushed] == "true"
    
    #TODO make activerecord
    @queue_items = PostQueue.where("pushed = #{pushed} AND post_id IS NOT NULL").order("id desc").page(params[:page]).per(5)
    @pushed = pushed
  end
  
  def force_push
    _queue_item = PostQueue.find(params[:id])

    social_push _queue_item
    redirect_to request.referrer, flash: { success: "Post item has been pushed successfully!" }
  end
  
  def consume_queue
    #PostsHelper
    social_push  
    
    if request.get?
      render :nothing => true, :status => 200, :content_type => 'text/html'
    else
      redirect_to request.referrer, flash: { success: "Queue has been consumed!"}
    end
    
  end

  def manage_adverts
  end
  
  def upload_advert
    logger.info "Entered UPLOAD ADVERT!!"
    id ||= Integer(params[:id])
    tmp = params[:advert][:upload].tempfile
  
    filename = params[:advert][:upload].original_filename
    extension = File.extname(params[:advert][:upload].original_filename)
    
    if (! %w[.jpg .gif .png].include? extension.downcase )  
      redirect_to request.referer, flash: { error: "Invalid File Format. Only Accepts: jpg, gif, and png" }
      return
    end
    
    file = File.join("app/assets/images/adverts", id > 0 ? "scrolling-advert-#{id}#{extension}" : "sidebar-right#{extension}")
    FileUtils.cp tmp.path, file
    
    #FileUtils.rm file
    
    logger.info "LEAVING upload_adverts!!"
    
    advert = id > 0 ? "Scrolling Advert banner # #{id}" : "Sidebar Advert"
    redirect_to request.referer, flash: { success: "#{advert} Successfully Updated!"}
  end
  
end