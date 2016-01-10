class AddFactorToFunctions < ActiveRecord::Migration
  def change
    add_column :functions, :factor, :decimal
  end
end
