class AddColumnToOperations < ActiveRecord::Migration
  def change
  	add_reference :operations, :task, index: true
  end
end
