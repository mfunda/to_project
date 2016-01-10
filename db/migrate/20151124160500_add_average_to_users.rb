class AddAverageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :average, :decimal
  end
end
