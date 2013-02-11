class PostsController < ApplicationController  
  def hot
    check_if_ajax 
  end

  def new
    check_if_ajax 
  end
  
  def top_good
    check_if_ajax 
  end
  
  def top_bad
    check_if_ajax 
  end

  def submit
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
end
