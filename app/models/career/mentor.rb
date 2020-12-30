# frozen_string_literal: true

class Career::Mentor < ApplicationRecord
  validates :first_name, :last_name, :email, presence: true

  has_many :allocated_calls, dependent: :nullify, class_name: 'Career::AllocatedCall'
  has_many :career_mentorships, dependent: :destroy, class_name: 'Career::Mentorship'
  has_many :students, dependent: :nullify, through: :career_mentorships
end
