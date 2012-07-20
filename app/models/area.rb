class Area < ActiveRecord::Base
  #https://github.com/apneadiving/Google-Maps-for-Rails/wiki/Model-Customization
  acts_as_gmappable 

  has_many :routes
	has_many :pictures, :as => :pictureable
	attr_accessible :latitude, :location, :longitude, :name, :gmaps

  def gmaps4rails_address
    self.location
  end
end
