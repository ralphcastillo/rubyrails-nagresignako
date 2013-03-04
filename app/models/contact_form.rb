class ContactForm < MailForm::Base
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :file,      :attachment => true

  attribute :message
  attribute :nickname,  :captcha  => true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "Feedback and Support",
      :to => "nagresignako@gmail.com",
      :from => "#{from_header}"
    }
  end
  
  def from_header
    Rails.logger.info self.email
    Rails.logger.info email
    email.blank? ? %('contact_form.headers.from') : email
  end
end