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

class SchoolPerformace < ApplicationRecord
  include SearchCop

  search_scope :search do
    attributes :id, :description
    attributes student: 'student.name'
    attributes user: 'user.name'
  end

  # Validation
  validates :student, :start_date, :finish_date, :description, presence: true

  # Association
  belongs_to :student, inverse_of: :school_performaces
  belongs_to :user, inverse_of: :school_performaces

  def sdate
    start_date.try(:strftime, '%d/%m/%Y')
  end

  def fdate
    finish_date.try(:strftime, '%d/%m/%Y')
  end

  def value_form
    student.id.to_s + ' - ' + student.name if student.present?
  end

  def self.report(student, start_date, finish_date)
    where('(start_date >= :start_date and finish_date <= :finish_date and student_id = :student_id)',
          start_date: start_date, finish_date: finish_date, student_id: student.to_i)
  end
end
