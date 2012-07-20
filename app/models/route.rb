class Route < ActiveRecord::Base
  has_many :routes
	has_many :pictures, :as => :pictureable		
  belongs_to :area
	attr_accessible :area_id, :directions, :grade, :latitude, :longitude
end
