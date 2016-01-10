class DropTableActionsUsers < ActiveRecord::Migration
  def change
  	drop_table :actions_users, :operations
  end
end
