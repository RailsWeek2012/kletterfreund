class AddPictureableIdToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :pictureable_id, :integer
  end
end
