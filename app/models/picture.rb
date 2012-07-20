class Picture < ActiveRecord::Base
	belongs_to :pictureable, :polymorphic => true
  #TODO remove type with migration
	attr_accessible :type, :pictureable_id, :pictureable_type, :path_to_picture, :path_to_picture_cache

  mount_uploader :path_to_picture, PictureUploader
end
