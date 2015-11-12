class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :products, :functions do |t|
       t.index [:product_id, :function_id]
       t.index [:function_id, :product_id]
    end
  end
end
