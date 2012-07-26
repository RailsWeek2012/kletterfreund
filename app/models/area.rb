class Area < ActiveRecord::Base
  #https://github.com/apneadiving/Google-Maps-for-Rails/wiki/Model-Customization
  acts_as_gmappable 

  has_many :routes
	has_many :pictures, :as => :pictureable
	attr_accessible :latitude, :location, :longitude, :name, :gmaps

  def gmaps4rails_address
    self.location
  end

  def to_select_label
    "#{name}"
  end

  def to_select_id
    "#{id}"
  end

  def routes
    Route.where("routes.area_id = ?", self.id)
  end


  def show_avg_route_difficulty?
    routes.length > 0
  end

end
