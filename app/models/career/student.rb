# frozen_string_literal: true

class Career::Student < ApplicationRecord
  validates :first_name, :last_name, :email, presence: true

  has_many :career_mentorships, dependent: :destroy, class_name: 'Career::Mentorship'
  has_many :mentors, dependent: :nullify, through: :career_mentorships
end
