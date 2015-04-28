class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.references :bus
      t.references :stop
      t.time :arrival #arrival time of a bus at a stop	
      t.timestamps null: false
    end
    add_index :schedules,["bus_id","stop_id"]
  end
end
