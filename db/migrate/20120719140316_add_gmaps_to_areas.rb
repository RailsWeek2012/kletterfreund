class AddGmapsToAreas < ActiveRecord::Migration
  def change
    add_column :areas, :gmaps, :boolean
  end
end
