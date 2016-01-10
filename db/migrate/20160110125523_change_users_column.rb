class ChangeUsersColumn < ActiveRecord::Migration
  def change
  	change_column :users, :rate, :decimal
  end
end
