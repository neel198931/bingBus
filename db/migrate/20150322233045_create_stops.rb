class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
      t.integer "longitude"
      t.integer "latitude"
      t.string "name"	
      t.timestamps null: false
    end
  end
end
