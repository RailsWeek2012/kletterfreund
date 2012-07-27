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

  def index
    gebiet = params[:gebiet]
    grade = params[:grade]
    @umkreis_ort = params[:umkreis_ort]
    umkreis_km = params[:umkreis_km]
    umkreis_km_index = Integer(umkreis_km)
    umkreis_km_value = km_select_values[umkreis_km_index-1]
    sql_clauses = Array.new
    sql_params = Hash.new

    joined_routes = Route.joins("INNER JOIN areas a on routes.area_id = a.id")

    unless gebiet.nil? or gebiet.empty?
      sql_clauses << "a.name like :gebiet || '%'"
      sql_params[:gebiet] = gebiet
    end

    unless grade.nil? or grade == "keine Angabe"
      sql_clauses << "grade = :grade"
      sql_params[:grade] = grade
    end
    
    @routes = joined_routes.where(sql_clauses.join(" and "), sql_params)
    @route_distance_to_umkreis_ort = Hash.new

    unless @umkreis_ort.nil? or @umkreis_ort.length == 0
      begin
        @routes = @routes.select { |r|
                                    distance_to_umkreis_ort = r.get_distance(@umkreis_ort)
                                    @route_distance_to_umkreis_ort[r.id] = distance_to_umkreis_ort
                                    umkreis_km_value < 0 || distance_to_umkreis_ort < umkreis_km_value * 1000
                                  }
      
        rescue
          flash.now[:alert] = "Suche fehlgeschlagen"
        redirect_to home_path
      end
    end
    
    flash.now[:notice] = "Suche erfolgreich"
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
        latitude_input = params[:route][:latitude]
        longitude_input = params[:route][:longitude]
        unless latitude_input.length > 0 and longitude_input.length > 0
          @route.latitude = selected_area.latitude
          @route.longitude = selected_area.longitude
        else
          @route.latitude = latitude_input
          @route.longitude = longitude_input
        end


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

  def km_select_values 
    [10, 25, 50, 100, 250, 500, -1]
  end


  def avg_user_grade route 
    avg = 0.0
    keine_angabe = 0
    route.comments.each { |c| 
                         keine_angabe += 1 unless uiaa_grades.index(c.user_grade) > 0
                        avg += uiaa_grades.index(c.user_grade) unless uiaa_grades.index(c.user_grade) == 0 }
    new_uiaa_grade_index = (avg / (route.comments.length - keine_angabe)).round
    uiaa_grades[new_uiaa_grade_index]
  end

  helper_method :show_avg_user_grade?
  helper_method :avg_user_grade
end