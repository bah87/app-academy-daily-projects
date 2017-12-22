class AlbumsController < ApplicationController
  def create
    band = Band.find_by(name: album_params[:band_id])
    id = band.id
    year = album_params[:year].to_i
    title = album_params[:title]
    live = album_params[:live_or_studio]
    
    @album = Album.new(title: title, year: year, live_or_studio: live, band_id: id)
    if @album.save
      render :show
    else
      render :new
    end
  end
  
  def new
  end
  
  def edit
    @album = Album.find(params[:id])
    render :edit
  end
  
  def show
    @album = Album.find(params[:id])
    render :show
  end
  
  def update
    band = Band.find_by(name: album_params[:band_id])

    new_params = {
      band_id: band.id,
      title: album_params[:title],
      year: album_params[:year].to_i,
      live_or_studio: album_params[:live_or_studio]
    }
    
    @album = Album.find(params[:id])
    if @album.update_attributes(new_params)
      redirect_to album_url(@album)
    else
      render :edit
    end
  end
  
  def destroy
    @album = Album.find(params[:id])
    band = @album.band
    if @album.destroy
      redirect_to band_url(band)
    else
      render :show
    end
  end
  
  private
  def album_params
    params.require(:album).permit(:title, :year, :live_or_studio, :band_id)
  end
end