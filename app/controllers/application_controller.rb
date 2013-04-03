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
      :secret_id => 'ab86e52276f06d94b429f2e76444c2ca' ,
      :token => session[:access_token])
  end
  
  def redirect_if_loggedout
    params[:secret_push_message] ||= ""
    
    if !admin_signedin? && params[:secret_push_message] != SECRET_MESSAGE
      redirect_to "/signin"
    end
  end
  
  def help
    Helper.instance
  end 

  class Helper
    include Singleton
    include ActionView::Helpers::TextHelper
  end
end

