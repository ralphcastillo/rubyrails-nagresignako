class UserMailer < ActionMailer::Base
  default from: "ichetester@gmail.com"
  
  def verify_user(user, post, url)
    @post = post
    @user = user
    @url = url
    mail(:to => user.email, :subject => "Verify Your Post")
  end
end
