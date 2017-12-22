class TracksController < ApplicationController
  def create
    @track = Track.new(track_params)
    if @track.save
      render :show
    else
      render :new
    end
  end
  
  def new
  end
  
  def edit
    @track = Track.find(params[:id])
    render :edit
  end
  
  def show
    @track = Track.find(params[:id])
    render :show
  end
  
  def update
    @track = Track.find(params[:id])
    if @track.update_attributes(track_params)
      redirect_to track_url(@track)
    else
      render :edit
    end
  end
  
  def destroy
    @track = Track.find(params[:id])
    album = @track.album
    if @track.destroy
      redirect_to album_url(album)
    else
      render :show
    end
  end
  
  private
  def track_params
    params.require(:track).permit(:title, :ord, :lyrics, :track_type, :album)
  end
end