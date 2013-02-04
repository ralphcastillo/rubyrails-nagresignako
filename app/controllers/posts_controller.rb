class PostsController < ApplicationController
  def hot
  end

  def new
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
end
