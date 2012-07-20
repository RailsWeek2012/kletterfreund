class PicturesController < ApplicationController
  def create
    debugger
    area_id = params[:picture][:area_id]
    params[:picture].delete(:area_id)
    @picture = Picture.new(params[:picture])
    
    @area = Area.find(area_id)

    if @picture.save
      @area.pictures << @picture
      flash.now[:notice] = "Sie haben das Bild erfolgreich hochgeladen"
    else
      flash.now[:alert] = "Fehler beim Hochladen des Bildes"
    end
    redirect_to areas_show_path(area_id)
  end
end
