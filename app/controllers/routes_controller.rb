class RoutesController < ApplicationController
  # GET /routes/1
  # GET /routes/1.json
  def show
    @route = Route.find(params[:id])
    @upload_picture = Picture.new
    @comment = Comment.new
  end

  # GET /routes/new
  # GET /routes/new.json
  def new
    @route = Route.new

  end


  # POST /routes
  # POST /routes.json
  def create
    @route = Route.new(params[:route])
    case params[:commit] 
    when "Gebiet suchen"
        @gebiete = Area.where("name LIKE ? || '%'", params[:route][:area_name])

        if @gebiete.length == 0
          flash.now[:notice] = "Es wurde kein Gebiet mit diesem Namen gefunden."
          render "new"
        end

        @selected_grade = params[:route][:grade]
        @entered_directions = params[:route][:directions]
        @entered_name = params[:route][:name]

          flash.now[:notice] = "Bitte waehlen sie ein Gebiet aus der Liste aus."
    when "Abspeichern"
        selected_area = Area.find_by_id(params[:route][:area_select_index])
        @route.area = selected_area
        @route.latitude = selected_area.latitude
        @route.longitude = selected_area.longitude

        if @route.save
          flash.now[:notice] = "Sie haben eine neue Route eingetragen."
          redirect_to routes_show_path(@route)
        else
          flash.now[:alert] = "Fehler beim Abspeichern der Route"
          render "new"
        end
    end

  end

  private

  def uiaa_grades
      ["I", "II", "III", "IV", "IV+", "V", "V+", "VI-", "VI", "VI+", "VII-", "VII", "VII+", "VIII", "VIII+", "IX-", "IX",
       "IX+", "X-", "X", "X+", "XI-", "XI", "XI+"]
  end

  helper_method :uiaa_grades
end