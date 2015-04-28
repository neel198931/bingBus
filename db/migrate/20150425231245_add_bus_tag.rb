class AddBusTag < ActiveRecord::Migration
  def change
  	add_column :schedules, :bustag, :integer
  end
end
