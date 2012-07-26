class Route < ActiveRecord::Base
  has_many :comments
	has_many :pictures, :as => :pictureable		
  belongs_to :area
	attr_accessible :area_id, :directions, :grade, :latitude, :longitude, :name

  attr_accessor :area_name, :area_select_index
  attr_accessible :area_name, :area_select_index

  def is_within_distance from_area, maximum_distance
    return get_distance(from_area) < maximum_distance * 1000;
  end

  def get_distance from_area
    to_route_coordinates = "#{latitude}, #{longitude}";
    gmaps_travel_directions = Gmaps4rails.destination({"from" => from_area, "to" => to_route_coordinates},
                                          {}, "clean")

    actual_distance = gmaps_travel_directions.first["distance"]["value"]
    return actual_distance
  end

  def has_different_cords_from_area?
    self.latitude != area.latitude or self.longitude != area.longitude
  end

  def gmaps_marker 
    return "#{self.latitude}, #{self.longitude}"
  end

  def show_avg_user_grade? 
     self.comments.length > 0
  end
end
