class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :route_id
      t.integer :user_id
      t.string :user_text
      t.string :user_grade

      t.timestamps
    end
  end
end
