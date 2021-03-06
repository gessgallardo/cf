# frozen_string_literal: true

FactoryBot.define do
  factory :career_allocated_call, class: 'Career::AllocatedCall' do
    student { create(:career_student) }
    mentor { create(:career_mentor) }
    description { Faker::Lorem.sentence }
    date_time { Faker::Time.between(from: DateTime.current, to: DateTime.current + 1.day) }
  end
end
