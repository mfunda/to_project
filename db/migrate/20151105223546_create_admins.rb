class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :login

      t.timestamps null: false
    end
  end
end
