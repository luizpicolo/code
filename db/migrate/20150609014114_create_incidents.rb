class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.references :student, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.date :date_incident
      t.text :description
      t.text :soluction

      t.timestamps null: false
    end
  end
end
