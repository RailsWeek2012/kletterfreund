class PicturesController < ApplicationController
  def create
    area_id = params[:picture][:area_id]
    unless area_id.nil?
      add_pic_to_area(area_id)
    end
    route_id = params[:picture][:route_id]
    unless route_id.nil?
      add_pic_to_route(route_id)
    end
  end

  def add_pic_to_area area_id
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

  def add_pic_to_route route_id
    params[:picture].delete(:route_id)
    @picture = Picture.new(params[:picture])
    
    @route = Route.find(route_id)

    if @picture.save
      @route.pictures << @picture
      flash.now[:notice] = "Sie haben das Bild erfolgreich hochgeladen"
    else
      flash.now[:alert] = "Fehler beim Hochladen des Bildes"
    end
    redirect_to routes_show_path(route_id)
  end

  def next
    unless params[:area_id].nil?
      redirect_to areas_show_path(params[:area_id], :picture_id => params[:picture_id])
    end
    unless params[:route_id].nil?
      redirect_to routes_show_path(params[:route_id], :picture_id => params[:picture_id])
    end
  end

  def prev
    unless params[:area_id].nil?
      redirect_to areas_show_path(params[:area_id], :picture_id => params[:picture_id])
    end
    unless params[:route_id].nil?
      redirect_to routes_show_path(params[:route_id], :picture_id => params[:picture_id])
    end
  end
end
