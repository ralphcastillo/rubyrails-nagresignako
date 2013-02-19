class AdminSessionsController < ApplicationController
  layout "blank_base"
  
  def new
  end
  
  def create
    
    @admin = Admin.find_by_email(params[:session][:email])
    if @admin && @admin.authenticate(params[:session][:password])
      sign_in @admin
      redirect_to admins_path
    else 
      flash.now[:error] = 'Invalid email/password combination'
      render "new"
    end
  end
  
  def destroy
    sign_out
    redirect_to root_url
  end
  
  def change_password
    if request.post?
      @admin = Admin.find_by_email(params[:session][:email])
      if @admin
        _link = change_pw_url({ email: @admin.email, secret: Digest::MD5.hexdigest(@admin.updated_at.to_s) })
        AdminPasswordMailer.email_password(@admin, _link).deliver
        flash.now[:success] = 'Reset Email request has been sent!'
      else 
        flash.now[:error] = 'Email does not exist in our records.'
      end
      render 'change_password'
    end
  end
  
  def admin_change_password 
    if request.put?
      @admin = Admin.find_by_email(params[:admin][:email])
      if @admin
        @admin.update_attributes(params[:admin])
        redirect_to '/signin'
      end
    else 
      @admin = Admin.find_by_email(params[:email])
      secret = params[:secret]
      
      if secret != Digest::MD5.hexdigest(@admin.updated_at.to_s)
        flash.now[:error] = "Sorry, the link that you are using has expired. Please request another reset."
        render 'change_password'
      end
    end
  end
end
