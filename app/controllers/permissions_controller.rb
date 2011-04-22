class PermissionsController < ApplicationController

  def authenticate
    flick = Flickr.new(request.url)
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
    if session[:user_id]
      redirect_to(sets_url)
    end
  end

  def create
    flick = Flickr.new(request.url)
    redirect_to flick.url
  end

  def destroy
    if session[:user_id]
      session[:user_id] = nil
    end
    redirect_to permissions_path, :notice => "You have been logged out."
  end

end
