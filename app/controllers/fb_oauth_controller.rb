class FbOauthController < ApplicationController
  def start
    redirect_to client.authorization.authorize_url(:redirect_uri => "http://#{request.env['HTTP_HOST']}/fb_oauth/callback/" ,
      :client_id => '488599381199316',:scope => 'email, birthday, likes')
  end

  def callback
    @access_token = client.authorization.process_callback(params[:code], :redirect_uri => "http://#{request.env['HTTP_HOST']}/fb_oauth/callback/")
    session[:access_token] = @access_token
    @fb_user = client.selection.me.info!
  end
end
