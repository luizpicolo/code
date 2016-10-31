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

# Class
class Incident < ApplicationRecord
  include SearchCop

  search_scope :search do
    attributes :id, :description
    attributes student: 'student.name'
    attributes user: 'user.name'
    attributes responsible: 'student.responsible'
  end

  # Validates
  validates :student, :date_incident, :description, presence: true
  validates :soluction, presence: true, on: :update

  # Association
  belongs_to :student, inverse_of: :incidents
  belongs_to :user, inverse_of: :incidents

  def value_form
    student.id.to_s + ' - ' + student.name if student.present?
  end

  def date_insident_format
    date_incident.try(:strftime, '%d/%m/%Y')
  end

  def sdate
    date_incident.try(:strftime, '%d/%m/%Y')
  end

  def fdate
    date_incident.try(:strftime, '%d/%m/%Y')
  end

  def self.report(student, start_date, finish_date)
    where('student_id = ?', student.to_i).where('date_incident >= ?', start_date)
      .where('date_incident <= ?', finish_date)
  end
end
