class RenameActionsToOperations < ActiveRecord::Migration
  def change
  	rename_table :actions, :operations
  end
end
