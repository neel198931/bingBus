class ChangeColumns < ActiveRecord::Migration
  def change
  		change_column :stops,:longitude,:float
  	change_column :stops,:latitude,:float
  end
end
