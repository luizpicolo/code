################################################################################
# The MIT License (MIT)
#
# Copyright (c) 2016 C.O.D.E
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
################################################################################

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
