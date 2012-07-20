class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.integer :area_id
      t.string :grade
      t.string :directions
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
