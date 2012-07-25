class Route < ActiveRecord::Base
  has_many :comments
	has_many :pictures, :as => :pictureable		
  belongs_to :area
	attr_accessible :area_id, :directions, :grade, :latitude, :longitude, :name

  attr_accessor :area_name, :area_select_index
  attr_accessible :area_name, :area_select_index
end
