class UserMailer < ActionMailer::Base
  default from: "ichetester@gmail.com"
  
  def verify_user(user, post)
    @post = post
    @user = user
    @url = "http://localhost:3000/posts/verify"
    mail(:to => user.email, :subject => "Verify Your Post")
  end
end
