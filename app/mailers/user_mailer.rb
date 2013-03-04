class UserMailer < ActionMailer::Base
  default from: "nagresignako@gmail.com"
  
  def verify_user(user, post, url)
    @post = post
    @user = user
    @url = url
    mail(:to => user.email, :subject => "Verify Your Post")
  end
  
  def send_feedback(contact)
    @contact = contact
    mail(:to => "nagresignako@gmail.com", :from => contact.email, :subject => "Feedback and Support")
  end
end
