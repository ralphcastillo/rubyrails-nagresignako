module AdminSessionsHelper

  def sign_in(admin)
    cookies.permanent[:remember_token] = { value:   admin.remember_token,
                                           expires: 20.years.from_now.utc }
    self.current_admin = admin
  end

  def sign_out
    self.current_admin = nil
    cookies.delete(:remember_token)
  end
  
  def current_admin=(admin)
    current_admin = admin
  end
  
  def current_admin
    current_admin ||= Admin.find_by_remember_token(cookies[:remember_token])
  end
  
  def admin_signedin?
    !current_admin.nil?
  end

end
