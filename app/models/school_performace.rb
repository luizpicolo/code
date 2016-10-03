class SchoolPerformace < ActiveRecord::Base
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
    where('student_id = ?', student.to_i).where('start_date >= ?', start_date)
      .where('finish_date <= ?', finish_date)
  end
end
