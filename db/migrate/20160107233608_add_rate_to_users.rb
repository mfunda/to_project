class AddRateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rate, :decimal
  end
end
