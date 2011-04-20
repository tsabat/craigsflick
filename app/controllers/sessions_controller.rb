class SessionsController < ApplicationController

  def index
    if session[:user_id]
      redirect_to sets_url
    else
      redirect_to permissions_url
    end
  end



  def show
    render :text => 'hi'
  end

  def create

     puts token
     if token

     else

     end
  end

  def destroy
    if session[:user_id]
      session[:user_id] = nil
    end
    redirect_to sessions_url
  end


end
