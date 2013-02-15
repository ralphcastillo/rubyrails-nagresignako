class ApplicationController < ActionController::Base
  protect_from_forgery
  include AdminSessionsHelper
  include PostsHelper
  
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  
  def redirect_if_loggedout
    if !admin_signedin? 
      redirect_to "/signin"
    end
  end
end
