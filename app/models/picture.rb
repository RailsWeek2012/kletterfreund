class Picture < ActiveRecord::Base
	belongs_to :pictureable, :polymorphic => true
	attr_accessible :path_to_picture, :type	
end
