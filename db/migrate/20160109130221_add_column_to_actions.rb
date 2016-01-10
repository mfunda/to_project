class AddColumnToActions < ActiveRecord::Migration
  def change
  	add_reference :actions, :task, index: true
  end
end
