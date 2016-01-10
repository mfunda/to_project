class CreateJoinTableUsersOperations < ActiveRecord::Migration
  def change
  	create_join_table :users, :operations do |t|
       t.index [:user_id, :operation_id]
       t.index [:operation_id, :user_id]
   end
  end
end
