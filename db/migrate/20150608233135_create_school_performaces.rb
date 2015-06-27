class CreateSchoolPerformaces < ActiveRecord::Migration
  def change
    create_table :school_performaces do |t|
      t.references :student, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.date :start_date
      t.date :finish_date
      t.text :description

      t.timestamps null: false
    end
  end
end
