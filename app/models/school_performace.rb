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
