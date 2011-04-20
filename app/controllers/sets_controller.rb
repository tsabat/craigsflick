class SetsController < ApplicationController
  def index
    flick = Flickr.new
    @sets = flick.sets(session[:user_id])

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    flick = Flickr.new
    @photos = flick.photos(params[:id])
  end
end
