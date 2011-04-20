class SetsController < ApplicationController
  def index
    flick = Flickr.new
    @sets = flick.sets(session[:user_id])

    respond_to do |format|
      format.html do
        if !@sets
          redirect_to permissions_path, :notice => "No Sets Found."
        end
      end
    end
  end

  def show
    flick = Flickr.new
    @photos = flick.photos(params[:id])
  end
end
