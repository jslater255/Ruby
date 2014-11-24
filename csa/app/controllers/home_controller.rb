class HomeController < ApplicationController
skip_before_action :login_required

  before_action :unforce_ssl

  protect_from_forgery

  def index
    #creates a variable in the session with the information for facebook to return the access token.
    session[:oauth] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, SITE_URL + '/home/callback')
    # we redirect to the auth URL with the permissions to be able to publish on the facbook wall
    redirect_to @auth_url =  session[:oauth].url_for_oauth_code(:permissions=>"publish_stream")

  end

  def callback
    if params[:code]
      # acknowledge code and get access token from FB.
      if !session[:access_token]
        session[:access_token] = session[:oauth].get_access_token(params[:code])
      end
    end
    #Creates a link to the facebook account using the access token
    @api = Koala::Facebook::API.new(session[:access_token])
    begin
      # We get all the status updates from the FB account and from the callback.html.erb file it will
      # iterate through them and display all.
      @graph_data = @api.get_object("/me/statuses", "fields"=>"message")
    rescue Exception=>ex
      puts ex.message
    end


    respond_to do |format|
      format.html {   }
    end


  end

end
