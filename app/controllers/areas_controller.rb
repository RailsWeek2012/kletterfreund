class AreasController < ApplicationController
  # GET /areas
  # GET /areas.json
  def index
    @areas = Area.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @areas }
    end
  end

  # GET /areas/1
  # GET /areas/1.json
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

  # GET /areas/1/edit
  def edit
    @area = Area.find(params[:id])
  end



  # PUT /areas/1
  # PUT /areas/1.json
  def update
    @area = Area.find(params[:id])

    respond_to do |format|
      if @area.update_attributes(params[:area])
        format.html { redirect_to @area, notice: 'Area was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    @area = Area.find(params[:id])
    @area.destroy

    respond_to do |format|
      format.html { redirect_to areas_url }
      format.json { head :no_content }
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
end
