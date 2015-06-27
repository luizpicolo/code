class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :responsible
      t.string :contact_responsible
      t.date :date_enrolment
      t.string :image
      t.boolean :status

      t.timestamps null: false
    end
  end
end
