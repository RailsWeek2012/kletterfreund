class Picture < ActiveRecord::Base
	belongs_to :pictureable, :polymorphic => true
  #TODO remove type with migration
	attr_accessible :type, :pictureable_id, :pictureable_type, :path_to_picture, :path_to_picture_cache

  mount_uploader :path_to_picture, PictureUploader

  def previous(offset = 0)    
    self.class.first(:conditions => ['id < ? and pictureable_id = ? and pictureable_type = ?', self.id, self.pictureable_id, self.pictureable_type], :limit => 1, :offset => offset, :order => "id DESC")
  end

  def next(offset = 0)
    self.class.first(:conditions => ['id > ? and pictureable_id = ? and pictureable_type = ?', self.id, self.pictureable_id, self.pictureable_type], :limit => 1, :offset => offset, :order => "id ASC")
  end

end
