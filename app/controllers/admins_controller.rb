class AdminsController < ApplicationController
  layout "admin_base"
  before_filter :redirect_if_loggedout    
  
  def index
    @admins = Admin.all
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
    @admin.password = @admin.password_confirmation = SecureRandom.urlsafe_base64
    
    if @admin.save
      link_item = change_pw_url({ email: @admin.email, secret: Digest::MD5.hexdigest(@admin.updated_at.to_s) })

      #AdminPasswordMailer.email_new_user(@admin, _link)#.deliver
      logger.debug "Saving User. Trying to send email..."
      logger.debug @admin.email
      logger.debug link_item
      mail = AdminPasswordMailer.email_new_user(@admin, link_item)
      mail.deliver
      
      flash.now[:success] = "Admin Saved. Invitation email has been sent."
      render 'show'
    else
      render 'new'
    end
  end
  
  def update  
    @admin = Admin.find(params[:id])
    @admin.updating_password  = false

    if @admin.update_without_password_confirmation(params[:admin])
      flash.now[:success] = "Admin Account update successful!"
      redirect_to @admin
    else
      render 'edit'
    end
  end
  
  def destroy 
    @admin = Admin.find(params[:id])
    
    if @admin.id == current_admin.id
      @admin.delete
      sign_out
      redirect_to '/'
    else 
      @admin.destroy
      redirect_to '/admins'
    end
  end
  
  def add
  end

  def edit
    @admin = Admin.find(params[:id])
  end
  
  private def redirect_if_loggedout
    if !admin_signedin? 
      redirect_to "/signin"
    end
  end
  
end
