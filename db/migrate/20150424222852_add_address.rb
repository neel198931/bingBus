class AddAddress < ActiveRecord::Migration
  def change
  	add_column :stops, :address, :string
  end
end
