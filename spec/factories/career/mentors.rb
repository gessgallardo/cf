# frozen_string_literal: true

FactoryBot.define do
  factory :career_mentor, class: 'Career::Mentor' do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    time_zone { Time.zone }
    calendar_id { 'random-id' }

    trait :with_students do
      transient do
        students_count { 5 }
      end

      after(:create) do |mentor, evaluator|
        create_list(:career_mentorship, evaluator.students_count, mentor: mentor)
        mentor.reload
      end
    end
  end
end
