# == Schema Information
#
# Table name: admins
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Admin < ActiveRecord::Base  

  attr_accessible :email, :name, :password, :password_confirmation, :role
  attr_accessor :updating_password
  
  has_secure_password
  
  before_save { 
    |admin| admin.email = email.downcase
    
    if admin.role == nil || admin.role == ""
      admin.role = "basic"
    end
  }
  before_save :create_remember_token
  
  validates :name, presence: true, length: {maximum: 50}
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}
  
  validates :password, presence: true, length: {minimum: 6}, :if => :should_validate_password?
  
  validates :password_confirmation, presence: true, :if => :should_validate_password?
  
  def update_without_password_confirmation(params={})
    params.delete(:password) if params[:password_confirmation].blank?
    params.delete(:password_confirmation) if params[:password].blank?

    update_attributes(params)
  end  
  
  #This is used to check whether the password should be checked or not. Useful for account edits
  def should_validate_password?
    updating_password || new_record?
  end
 
  #This is used for session keeping.
  def create_remember_token 
    self.remember_token = SecureRandom.urlsafe_base64
  end

end
