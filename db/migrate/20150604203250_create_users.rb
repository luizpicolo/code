class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.boolean :admin
      t.boolean :status

      t.timestamps null: false
    end
  end
end
