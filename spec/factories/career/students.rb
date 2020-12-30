# frozen_string_literal: true

FactoryBot.define do
  factory :career_student, class: 'Career::Student' do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    time_zone { Time.zone }

    trait :with_mentors do
      transient do
        mentors_count { 5 }
      end

      after(:create) do |student, evaluator|
        create_list(:career_mentorship, evaluator.mentors_count, student: student)
        student.reload
      end
    end
  end
end
