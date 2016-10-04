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
