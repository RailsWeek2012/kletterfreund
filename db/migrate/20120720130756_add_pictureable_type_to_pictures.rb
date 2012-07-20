class AddPictureableTypeToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :pictureable_type, :string
  end
end
