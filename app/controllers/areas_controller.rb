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

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @area }
    end
  end

  def new
    @area = Area.new
  end

    # POST /areas
  # POST /areas.json
  def create
    @area = Area.new(params[:area])
    if(params[:button] = "search_location") 
      search_map
      render "search_map"
      return
    else 
      if params[:button] = "button" && @area.save 
        redirect_to home_path, notice: "Sie haben sich ein neues Gebiet eingetragen."
      else
        render "new"
      end
    end
  end

  def search_map     
      begin
        results = Gmaps4rails.geocode( @area.location)
        @area.latitude = results.first[:lat]
        @area.longitude = results.first[:lng]
        @json =  @area.to_gmaps4rails
    rescue Exception => e
      flash.now[:alert] = "Fehler beim Auffinden der Location"
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
end
