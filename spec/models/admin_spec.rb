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

require 'spec_helper'

describe Admin do
  pending "add some examples to (or delete) #{__FILE__}"
  
  before do
    @admin = Admin.new(name: "Example Admin", email: "admin@someemail.com",
                        password: "foobar", password_confirmation: "foobar")
  end
  
  subject { @admin }
  
  it { should respond_to(:name)}
  it { should respond_to(:email)}
  it { should respond_to(:password_digest)}
  it { should respond_to(:role)}
  
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}
  
  it { should respond_to(:authenticate) }
  
  it { should be_valid }
  
  describe "when name is not present" do
    before {@admin.name = " "}
    it { should_not be_valid }
  end
  
  describe "when email is not present" do
    before {@admin.email = " "}
    it { should_not be_valid }
  end
  
  describe "when name is too long" do 
    before { @admin.name = "hello" * 50}
    it { should_not be_valid }
  end
    
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @admin.email = invalid_address
        @admin.should_not be_valid
      end      
    end
  end
  
  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @admin.email = valid_address
        @admin.should be_valid
      end      
    end
  end
  
   describe "when email address is already taken" do
    before do
      user_with_same_email = @admin.dup
      user_with_same_email.email.upcase!
      user_with_same_email.save
    end

    it { should_not be_valid }
  end
  
  describe "when password is not present" do
    before { @admin.password = @admin.password_confirmation = " "}
    
    it { should_not be_valid }
  end
  
  describe "when password and confirmation do not match" do
    before { @admin.password_confirmation = "not foobar" }
  
    it { should_not be_valid }
  end
  
  describe "when password confirmation is nil" do
    before { @admin.password_confirmation = nil }
    it { should_not be_valid }
  end
  
  describe "return value of authenticate method" do
    before { @admin.save }
    let(:found_admin) { Admin.find_by_email(@admin.email) }

    describe "with valid password" do
      it { should == found_admin.authenticate(@admin.password) }
    end
  
    describe "with invalid password" do
      let(:admin_for_invalid_password) { found_admin.authenticate("invalid") }

      it { should_not == admin_for_invalid_password }
      specify {admin_for_invalid_password.should be_false }
    end
  end
  
  describe "with a password that's too short" do
    before { @admin.password = @admin.password_confirmation = "a"*5 }
    it { should be_invalid }
  end
end
