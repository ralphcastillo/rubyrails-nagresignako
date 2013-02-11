class ApplicationController < ActionController::Base
  protect_from_forgery
  include AdminSessionsHelper
  
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  
end
