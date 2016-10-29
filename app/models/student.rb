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

class Student < ApplicationRecord
  include SearchCop

  search_scope :search do
    attributes :name, :responsible, :id
  end

  mount_uploader :image, StudentUploader

  # Validates
  validates :name, :responsible, :contact_responsible, :date_enrolment, presence: true

  # Association
  has_many :school_performaces, inverse_of: :student
  has_many :incidents, inverse_of: :student
  has_many :reports, inverse_of: :student

  def status
    false if read_attribute(:status).blank?
  end

  def date_enrolment_format
    date_enrolment.try(:strftime, '%d/%m/%Y')
  end

  def show_name
    id.to_s << ' - ' << name
  end
end
