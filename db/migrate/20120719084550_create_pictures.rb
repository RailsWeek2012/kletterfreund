class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :type
      t.string :path_to_picture

      t.timestamps
    end
  end
end
