# frozen_string_literal: true

FactoryBot.define do
  factory :career_mentorship, class: 'Career::Mentorship' do
    student { create(:career_student) }
    mentor { create(:career_mentor) }
  end
end
