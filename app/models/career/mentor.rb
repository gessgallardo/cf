class Career::Mentor < ApplicationRecord
  validates :first_name, :last_name, :email, presence: true

  has_many :students, dependent: :nullify, through: :career_mentorships
end
