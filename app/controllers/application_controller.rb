class ApplicationController < ActionController::Base
  protect_from_forgery
  include AdminSessionsHelper
  
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  
  def client
    @client ||= FBGraph::Client.new(:client_id => '366867723400168',
      :secret_id => '33053de31deab4b5ed2f70f822950e71' ,
      :token => session[:access_token])
  end
  
end
