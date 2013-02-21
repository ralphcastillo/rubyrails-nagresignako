class ApplicationController < ActionController::Base
  protect_from_forgery
  include AdminSessionsHelper
  include PostsHelper
  SECRET_MESSAGE = "e05e121f2ca8d1180eb49e37b761533e"
  
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  
  def client
    @client ||= FBGraph::Client.new(:client_id => '488599381199316',
      :secret_id => '572a38ed645c0b275a2ca541ac98bc3d' ,
      :token => session[:access_token])
  end
  
  def redirect_if_loggedout
    params[:secret_push_message] ||= ""
    
    if !admin_signedin? && params[:secret_push_message] != SECRET_MESSAGE
      redirect_to "/signin"
    end
  end
end
