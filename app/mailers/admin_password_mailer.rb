class AdminPasswordMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def email_password(admin, link)
    @admin  = admin
    @link = link
    mail(:to => @admin.email, :subject => "Nagresignako.com | Reset Password")
  end
  
  def email_new_user(admin, link)  
    @admin = admin
    @link = link

    logger.debug "Mailing Attempt"
    mail(:to => @admin.email, :subject => "Nagresignako.com | Welcome New Administrator")
  end
end