class User < ApplicationRecord
  include SearchCop

  search_scope :search do
    attributes :id, :name, :email
  end

  # validates :password, confirmation: true
  # validates :password_confirmation, presence: true

  # Association
  has_many :school_performaces, inverse_of: :user
  has_many :incidents, inverse_of: :user

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
end
