class PermissionsController < ApplicationController

  def authenticate
    flick = Flickr.new
    if frob = request[:frob]
      if login = flick.login(frob)
        session[:user_id] = login[:user_id]
        redirect_to sets_url
      else
        redirect_to permissions_url, :notice => "User refused authentication"
      end
    else
      redirect_to permissions_url, :notice => "User refused authentication"
    end
  end

  def index
    flick = Flickr.new
    @flickr_auth_url = flick.url
  end
end
