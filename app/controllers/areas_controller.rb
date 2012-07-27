class AreasController < ApplicationController

  #def index
  #  @areas = Area.all
  #end

  def show
    @area = Area.find(params[:id])
    @upload_picture = Picture.new
  end

  def new
    @area = Area.new
    @json = json_for_default_area
  end


    # POST /areas
  # POST /areas.json
  def create
    @area = Area.new(params[:area])
    #TODO look for custom parameter instead of button caption
    case params[:commit] 
      when "Auf Karte suchen"
        begin
          #search map for
          geocode_results = Gmaps4rails.geocode( @area.location)
          @area.latitude = geocode_results.first[:lat]
          @area.longitude = geocode_results.first[:lng]
          @json = @area.to_gmaps4rails
          @show_precise_location = true
          @input_name_placeholder = @area.name
          @input_location_placeholder= @area.location
          @form_submit_label= "Abspeichern"
          @form_submit_action ="submit_save_map"
          flash.now[:notice] = "Das Klettergebiet wurde gefunden, sie koennen jetzt speichern"
        rescue Exception => e
          @show_precise_location = nil
          @json = json_for_default_area
          flash.now[:alert] = "Fehler beim Auffinden der Location "
          render "new"
        end
        
        return #TODO is this needed or does execution end after render
      when "Abspeichern"
        if @area.save
          flash.now[:notice] = "Sie haben ein neues Gebiet eingetragen."
          redirect_to areas_show_path(@area)
        else
          flash.now[:alert] = "Fehler beim Abspeichern der Location"
          render "new"
        end
    end
  end

  private

  def json_for_default_area
    #show default map
    begin
      @json = Area.first.to_gmaps4rails
    rescue Exception => e
      flash.now[:alert] = "Fehler beim Auffinden der Default-Location"
    end
  end

  # TODO move to model

  def avg_route_difficulty area
    avg = 0.0
    keine_angabe = 0
    area.routes.each { |r|  
                       keine_angabe += 1 unless uiaa_grades.index(r.grade) > 0
                       avg += uiaa_grades.index(r.grade) unless uiaa_grades.index(r.grade) == 0 }
    new_uiaa_index = (avg / (area.routes.length - keine_angabe)).round
    uiaa_grades[new_uiaa_index]
  end

  helper_method :avg_route_difficulty
end
