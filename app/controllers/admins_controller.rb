class AdminsController < ApplicationController
  layout "admin_base"
  
  def index
    @admins = Admin.all
  end

  def login
  end
  
  def show
      @admin = Admin.find(params[:id])
  end
  
  #New Admin Pages
  def new
    @admin = Admin.new
  end
  
  def create
    @admin = Admin.new(params[:admin])
    @admin.password = @admin.password_confirmation = ("random"* 10) + rand(10000).to_s
    
    if @admin.save
      redirect_to @admin
    else
      render 'new'
    end
  end
  
  def update  
    @admin = Admin.find(params[:id])
    @admin.updating_password  = false

    if @admin.update_without_password_confirmation(params[:admin])
      redirect_to @admin
    else
      render 'edit'
    end
  end
  
  def add
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def change_password
  end

  def manage_posts
  end

  def spam
  end
end
