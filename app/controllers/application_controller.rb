class ApplicationController < ActionController::Base
  protect_from_forgery
  include AdminSessionsHelper
  include PostsHelper
  
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  
  def client
    @client ||= FBGraph::Client.new(:client_id => '488599381199316',
      :secret_id => '572a38ed645c0b275a2ca541ac98bc3d' ,
      :token => session[:access_token])
  end
  
  def redirect_if_loggedout
    if !admin_signedin? 
      redirect_to "/signin"
    end
  end
end
