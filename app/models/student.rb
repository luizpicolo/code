class Student < ApplicationRecord
  include SearchCop

  search_scope :search do
    attributes :name, :responsible, :id
  end

  mount_uploader :image, StudentUploader

  # Validates
  validates :name, :responsible, :contact_responsible, :date_enrolment,
            :status, presence: true

  # Association
  has_many :school_performaces, inverse_of: :student
  has_many :incidents, inverse_of: :student
  has_many :reports, inverse_of: :student

  def date_enrolment_format
    date_enrolment.try(:strftime, '%d/%m/%Y')
  end

  def show_name
    id.to_s << ' - ' << name
  end
end
